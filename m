Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271959AbRHVKtN>; Wed, 22 Aug 2001 06:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271149AbRHVKtD>; Wed, 22 Aug 2001 06:49:03 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:17163 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271982AbRHVKsz>; Wed, 22 Aug 2001 06:48:55 -0400
Date: Wed, 22 Aug 2001 11:48:02 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Taylor Carpenter <taylorcc@codecafe.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
In-Reply-To: <E15ZVXa-0001Jb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0108221146270.18880-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:

> > I've noticed kernels 2.4.7, 2.4.8 and 2.4.9 can oops when modprobing
> > floppy.o under certain circumstances (specifically I've noticed it when
> 
> floppy.o crashes the box or prints bad things if there is no floppy 
> controller. I've not yet had time to investigate

Ok - it's no big problem, I just don't compile it as a module now (the
kernel is used on both boxes with floppy and without, so it needs to be
there, but I have no problem with compiling it into the kernel - it
doesn't seem to break, just says "no floppy controller present" on the
floppy-less boxes.)

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


