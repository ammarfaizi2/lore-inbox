Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262491AbSKCVt6>; Sun, 3 Nov 2002 16:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSKCVt6>; Sun, 3 Nov 2002 16:49:58 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:43015 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262491AbSKCVt6>; Sun, 3 Nov 2002 16:49:58 -0500
Date: Sun, 3 Nov 2002 22:55:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: troubles with piping make output
In-Reply-To: <20021103213920.H5589@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211032252000.13258-100000@serv>
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua>
 <20021103182805.GA1057@mars.ravnborg.org> <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.44.0211032106010.6949-100000@serv> <20021103202446.F5589@flint.arm.linux.org.uk>
 <Pine.LNX.4.44.0211032146240.6949-100000@serv> <20021103212435.G5589@flint.arm.linux.org.uk>
 <Pine.LNX.4.44.0211032227100.6949-100000@serv> <20021103213920.H5589@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Russell King wrote:

> > As I already said, oldconfig still works as before. Maybe you should have 
> > tried it first?
> 
> I have.  However, I thought you were about to change the oldconfig
> behaviour.  My bad.

Why should I? The original problem was with 'make | tee', which might run 
a silent version of oldconfig.

> The patch is still required, though, to make sure stdout is flushed to
> the user before asking a question, which doesn't happen in the case I
> highlighted.

Will add. Thanks.

bye, Roman

