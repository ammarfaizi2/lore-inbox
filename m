Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTBJVhL>; Mon, 10 Feb 2003 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTBJVhL>; Mon, 10 Feb 2003 16:37:11 -0500
Received: from mail.buerotec.de ([217.89.50.162]:14599 "EHLO mail.buerotec.de")
	by vger.kernel.org with ESMTP id <S265306AbTBJVhJ>;
	Mon, 10 Feb 2003 16:37:09 -0500
Date: Mon, 10 Feb 2003 22:44:30 +0100
From: Kay Sievers <lkml@vrfy.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 defconfig+CONFIG_MODVERSIONS=y -> syntax error
Message-ID: <20030210214430.GC16226@vrfy.org>
References: <20030210205752.GB16226@vrfy.org> <Pine.LNX.4.44.0302101523130.3320-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0302101523130.3320-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:26:30PM -0600, Kai Germaschewski wrote:
> On Mon, 10 Feb 2003, Kay Sievers wrote:
> 
> > On Mon, Feb 10, 2003 at 02:49:36PM -0600, Kai Germaschewski wrote:
> > > On Mon, 10 Feb 2003, Kay Sievers wrote:
> > > >   ld:arch/i386/kernel/.tmp_time.ver:1: syntax error
> > > 
> > > Interesting. Thanks for testing CONFIG_MODVERSIONS. I cannot reproduce it
> > > here, unfortunately (not even with the same .config). What does
> > > arch/i386/kernel/.tmp_time.ver look like?
> > 
> > pim:/usr/src/linux-2.5.60# cat arch/i386/kernel/.tmp_time.ver
> > __crc_i = 0x_lock ;     ac2d2492
> 
> Okay, that's not a problem with ld, but (most likely) sed.
> 
> I hope the appended patch fixes it.

Yes, now it compiles.
¶

> For the record, what version of sed do you have? (sed -V)¶
¶
kay@pim:~$ sed -V¶
GNU sed version 3.02¶
¶
¶
Kay¶

