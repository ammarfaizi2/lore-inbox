Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311470AbSCSRYw>; Tue, 19 Mar 2002 12:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311469AbSCSRYl>; Tue, 19 Mar 2002 12:24:41 -0500
Received: from smtp.polymtl.ca ([132.207.4.11]:4555 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S311470AbSCSRYZ>;
	Tue, 19 Mar 2002 12:24:25 -0500
Message-ID: <3C977438.AD5BCED@polymtl.ca>
Date: Tue, 19 Mar 2002 12:24:08 -0500
From: Christian Robert <christian.robert@polymtl.ca>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, fr-CA
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to run kernel 2.4.18  it panic at boot
In-Reply-To: <3C96C714.E6967570@polymtl.ca> <20020319085943.B4750@namesys.com> <3C976267.71756479@polymtl.ca> <20020319191359.A8533@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
> On Tue, Mar 19, 2002 at 11:08:07AM -0500, Christian Robert wrote:
> 
> > I have reiserfs, but no hpfs partitions ( but yes, it is compiled in the kernel )
> > my next step will be to recompile kernel without "hpfs" to see if it help.
> >
> Yes, it should
> Or alternatively you can move reiserfs up in the list of objects to be linked
> in /usr/src/linux/fs/Makefile
> 
> Bye,
>     Oleg

Running 2.4.18 now. 

Removing "hpfs" from the kernel config solved my problem.

So, something has probably changed between kernel 2.4.17 and 2.4.18
regarding detection of "hpfs" partitions ?

many thanks,
Xtian.
