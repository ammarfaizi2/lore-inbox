Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbTA1NAe>; Tue, 28 Jan 2003 08:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTA1NAe>; Tue, 28 Jan 2003 08:00:34 -0500
Received: from home.wiggy.net ([213.84.101.140]:31166 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S265262AbTA1NAe>;
	Tue, 28 Jan 2003 08:00:34 -0500
Date: Tue, 28 Jan 2003 14:09:53 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128130953.GW4868@wiggy.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> <200301281144.h0SBi0ld000233@darkstar.example.net> <20030128114840.GV4868@wiggy.net> <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Alan Cox wrote:
> The real question is whether you want to do this in the kernel or simply at
> the moment the kernel flips to user space. An init can easily open vt2,
> draw a pretty boot screen with something like nanogui or bogl and then 
> continue to spew the text to vt1 so anyone can see the text messages if
> need be.

It takes a while before the kernel starts init though, especially if you
have things like SCSI controllers to initialise. If you do not use fb
you can have your bootloader setup a pretty bootscreen, but if you need
fb I don't see how you can prevent the textscreen with kernel messages.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
