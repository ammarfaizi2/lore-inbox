Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSJ3Jjs>; Wed, 30 Oct 2002 04:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264645AbSJ3Jjr>; Wed, 30 Oct 2002 04:39:47 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:8966 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264644AbSJ3Jjr>; Wed, 30 Oct 2002 04:39:47 -0500
Date: Wed, 30 Oct 2002 10:45:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Erik Andersen <andersen@codepoet.org>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel conf 1.3
In-Reply-To: <20021030080914.GA7371@codepoet.org>
Message-ID: <Pine.LNX.4.44.0210301041160.13257-100000@serv>
References: <3DBF4D6B.364A6DCC@linux-m68k.org> <20021030080914.GA7371@codepoet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Oct 2002, Erik Andersen wrote:

> It seems that 2.5.45 does not exist.  Is this vs a BK snapshot?

http://marc.theaimsgroup.com/?l=linux-kernel&m=103595086131620&w=2
Argh, so I removed 1.3 too. If anyone has problems during 'make xconfig',
although he has the qt development package installed (and which doesn't 
set QTDIR), can get an updated Makefile on request.

> Attempting to install vs 2.5.44 fails rather spectacularly.
> There was even a segfault in lkcc at one point while doing
> a make install KERNELSRC=<blah>/linux-2.5.44

Without a log it's hard to say, but usually it's because of syntax errors 
in the old config files.

bye, Roman

