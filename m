Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbRGPWK1>; Mon, 16 Jul 2001 18:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267722AbRGPWKR>; Mon, 16 Jul 2001 18:10:17 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.121.12]:52939 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267721AbRGPWKG>; Mon, 16 Jul 2001 18:10:06 -0400
Date: Mon, 16 Jul 2001 17:09:55 -0500
From: J Troy Piper <jtp@dok.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: J Troy Piper <jtp@dok.org>, linux-kernel@vger.kernel.org,
        Alan Cox <laughing@shared-source.org>
Subject: Re: [Problem] Linux 2.4.5-ac17 ipt_unclean 'fixes'
Message-ID: <20010716170955.A23722@dok.org>
In-Reply-To: <20010714170021.B1391@dok.org> <m15M5cN-000CK9C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m15M5cN-000CK9C@localhost>; from rusty@rustcorp.com.au on Mon, Jul 16, 2001 at 08:28:45PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, the patches work and I see that they have made it into 2.4.5-ac3 
with the rest of the Linux -pre merge.  Thanks.

Troy.

On Mon, Jul 16, 2001 at 08:28:45PM +1000, Rusty Russell wrote:
> In message <20010714170021.B1391@dok.org> you write:
> > today) but there seems to be a problem with the ipt_unclean fixes by Rusty 
> > Russell.  ANY incoming packets from any interface (ppp0 and eth0) are 
> > marked as 'unclean' with some variation on the following syslog entry:
> > 
> > Jul  8 23:16:04 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
> 
> Please try this patch which fixes this as well, which is in Linus'
> pre-patches.
> 
> Rusty.
> --
> Premature optmztion is rt of all evl. --DK
> 
