Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280822AbRKRIPy>; Sun, 18 Nov 2001 03:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281045AbRKRIPo>; Sun, 18 Nov 2001 03:15:44 -0500
Received: from web21106.mail.yahoo.com ([216.136.227.108]:19180 "HELO
	web21106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280822AbRKRIP1>; Sun, 18 Nov 2001 03:15:27 -0500
Message-ID: <20011118081525.50385.qmail@web21106.mail.yahoo.com>
Date: Sun, 18 Nov 2001 00:15:25 -0800 (PST)
From: "Roy S.C. Ho" <scho1208@yahoo.com>
Subject: Re: Raw access to block devices
To: ptb@it.uc3m.es
Cc: linux-kernel@vger.kernel.org, scho@whizztech.com
In-Reply-To: <200111171615.fAHGFM027673@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, thanks for your help. I found that the
control device is only for GETBIND or SETBIND. It
seems that the binded devices still have to be char
devices. Is there a way to change this?
Your help is much appreciated. Thanks.

--- "Peter T. Breuer" <ptb@it.uc3m.es> wrote:
> "A month of sundays ago Roy S.C. Ho wrote:"
> > I would like to write a driver for a block device
> that
> > is better to be accessed directly without going
> > through the buffer cache. I read the source code
> raw.c
> > and learnt that linux does have raw I/O support.
> > However, it seems to me that the support only
> provides
> > a character device interface to users. Is there a
> 
> I think that's the control device. You can work out
> how to use it
> by looking at the ioctls in raw.c. But, yes, sure,
> if you get some
> "official" news on how to work it, let me know too
> and I'll use the
> info like a shot!
> 
> > simple way to maintain the block device interface
> to
> > user programs / other parts of the kernel, while
> > bypassing the buffer cache system?
> 
> Peter
> -


__________________________________________________
Do You Yahoo!?
Find the one for you at Yahoo! Personals
http://personals.yahoo.com
