Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSKCVXV>; Sun, 3 Nov 2002 16:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSKCVXV>; Sun, 3 Nov 2002 16:23:21 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4622 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262506AbSKCVXR>; Sun, 3 Nov 2002 16:23:17 -0500
Date: Sun, 3 Nov 2002 22:29:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: troubles with piping make output
In-Reply-To: <20021103212435.G5589@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211032227100.6949-100000@serv>
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua>
 <20021103182805.GA1057@mars.ravnborg.org> <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.44.0211032106010.6949-100000@serv> <20021103202446.F5589@flint.arm.linux.org.uk>
 <Pine.LNX.4.44.0211032146240.6949-100000@serv> <20021103212435.G5589@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Russell King wrote:

> > Huh? What do you mean? oldconfig still works as before,
> 
> ssh host make -C $tree oldconfig ARCH=arm
> 
> that doesn't allocate a terminal.  I want such commands to _prompt_ for
> input.  If they die because its not a terminal, I consider that _broken_.
> Why?  The command is able to read input from a human, and write its output
> to a human via the ssh pipes.
> 
> If you insist on breaking this, I'll insist on fixing it.  Its a misfeature
> that you refuse to run in this situation.

As I already said, oldconfig still works as before. Maybe you should have 
tried it first?

bye, Roman

