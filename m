Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSJOPYd>; Tue, 15 Oct 2002 11:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSJOPYd>; Tue, 15 Oct 2002 11:24:33 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:60318 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263986AbSJOPYb>; Tue, 15 Oct 2002 11:24:31 -0400
Date: Tue, 15 Oct 2002 10:30:02 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.42 broke ARM zImage/Image
In-Reply-To: <20021015172201.A1406@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0210151028270.10165-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Sam Ravnborg wrote:

> On Tue, Oct 15, 2002 at 12:22:43AM +0100, Russell King wrote:
> > Sam & Kai, lkml and others who join us on this happy day.
> > 
> > So, basically, I'm screwed at the moment, unless someone has anything
> > else to suggest.
>
> How about a simple workaround for now:
> [...]

Actually, we figured out what the problem was now, the link script was 
given as an argument to ld twice, which obviously confused it. After 
fixing that, all is well.

Thanks anyway,
--Kai





