Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289105AbSAJHnI>; Thu, 10 Jan 2002 02:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289111AbSAJHm6>; Thu, 10 Jan 2002 02:42:58 -0500
Received: from sj1-3-1-20.securesites.net ([192.220.127.117]:17938 "EHLO
	sj1-3-1-20.securesites.net") by vger.kernel.org with ESMTP
	id <S289105AbSAJHml>; Thu, 10 Jan 2002 02:42:41 -0500
Date: Thu, 10 Jan 2002 07:42:40 +0000
From: Nathan Myers <ncm-nospam@cantrip.org>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de, davem@redhat.com
Subject: Re: bad patch in aic7xxx_linux.c
Message-ID: <20020110074240.B25480@cantrip.org>
Mail-Followup-To: Nathan Myers <ncm-nospam@cantrip.org>,
	linux-kernel@vger.kernel.org, axboe@suse.de, davem@redhat.com
In-Reply-To: <20020109090628.A18526@cantrip.org> <20020109.012046.21928803.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020109.012046.21928803.davem@redhat.com>; from davem@redhat.com on Wed, Jan 09, 2002 at 01:20:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 01:20:46AM -0800, David S. Miller wrote:
> From: Nathan Myers <ncm-nospam@cantrip.org>
>>    In patch-2.4.18-pre2, a nonsensical change was made in 
>>    linux/drivers/scsi/aic7xxx/aic7xxx_linux.c .  While apparently 
>>    harmless, it suggests to me that you had intended to fold in an 
>>    entirely different patch, and "missed".
>    
> Missed?  That patch fixes a lethal bug.

Indeed, I missed that the value was also passed to ahc_linux_map_seg()
before being clobbered in the next statement.  
 
>    I don't find a current maintainer for aic7xxx listed in MAINTAINERS.
> 
> It's listed in the aic7xxx sources, but the fix in question came to
> Marcelo via Jens Axboe.

One can guess, but there are no addresses for anyone noted there later 
than 1999.  In particular, Justin's address isn't listed.

I am interested in hotplugged aic7xxx (1480 CardBus).  I will be posting 
an Oops shortly related to that, unless somebody tells me not to bother.  

Nathan Myers
ncm at cantrip dot org
