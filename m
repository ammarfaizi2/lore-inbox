Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTA1Og3>; Tue, 28 Jan 2003 09:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTA1Og3>; Tue, 28 Jan 2003 09:36:29 -0500
Received: from hexagon.stack.nl ([131.155.140.144]:16915 "EHLO
	hexagon.stack.nl") by vger.kernel.org with ESMTP id <S266320AbTA1Og1>;
	Tue, 28 Jan 2003 09:36:27 -0500
Date: Tue, 28 Jan 2003 15:45:45 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <20030128143235.GY4868@wiggy.net>
Message-ID: <20030128153533.X28781-100000@snail.stack.nl>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com>
 <200301281144.h0SBi0ld000233@darkstar.example.net> <20030128114840.GV4868@wiggy.net>
 <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk> <20030128130953.GW4868@wiggy.net>
 <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk> <20030128143235.GY4868@wiggy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Wichert Akkerman wrote:

> Agreed - what you probably want to do is have a minimal kernel that
> boots an initrd which loads modules for the rest. If the kernel is
> small enough you don't care for its boot messages: if it fails the
> hardware is screwed and your box has to be repaired (esp. if you are
> dealing with embedded/special purpose systems where the people using
> the box can't even see the hardware).

Why are you guys walking around the issue ? There are people demanding for
a feature, and they are marked as complete idiots. Linux is no kernel for
your computer only, it is a general purpose kernel, used in PDAs, set top
boxes, cars, mp3 players, servers, oh, and desktop computers. The nice
thing of features of the Linux kernel is that you can disable them if you
don't like them. I think the fbcon system is shit, so I disable it,
instead of telling everyone who uses it they are morons.

Oh, and using modules is a (minor) security issue. I have all my drivers
compiled in the kernel. I like it and it is secure.

Jos
