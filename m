Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbTA1TB1>; Tue, 28 Jan 2003 14:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTA1TB1>; Tue, 28 Jan 2003 14:01:27 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:37256 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267629AbTA1TB0>; Tue, 28 Jan 2003 14:01:26 -0500
Date: Tue, 28 Jan 2003 11:10:18 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>, kai@tp1.ruhr-uni-bochum.de
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030128191018.GD17737@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20030123193540.GD13137@ca-server1.us.oracle.com> <20030128055643.AAC532C0F9@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128055643.AAC532C0F9@lists.samba.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 12:58:40PM +1100, Rusty Russell wrote:
> And then you'll die horribly next time Kai or I change the way modules
> are built.
> 
> Really, using the Makefiles is always the most future-proof way!
I've actually converted my stuff to use the Makefiles, which does simplify
things, but the problem I had was mainly with the whole vermagic.c stuff and
needing a full source tree + compiled objects (or having the tree writeable
by users who want to compile modules) around just to build my module.
Anyway, Joel Becker, Christian Zander and others have eloquently voiced my
complaints previously in this thread, so I won't go over them again :)

As far as using the kernel build system, so far so good - it's nice, and
builds things correctly though I'm having some trouble getting it to
install my module correctly, which may just indicate that I need to re-read
the docs.
	--Mark

--
Mark Fasheh
Software Developer, Oracle Corp
mark.fasheh@oracle.com
