Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbTALVJv>; Sun, 12 Jan 2003 16:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267525AbTALVJv>; Sun, 12 Jan 2003 16:09:51 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:52239 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267520AbTALVJu>; Sun, 12 Jan 2003 16:09:50 -0500
Date: Sun, 12 Jan 2003 21:18:39 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: make xconfig broken in bk current
Message-ID: <20030112211839.GA56253@compsoc.man.ac.uk>
References: <200301121512.59840.tomlins@cam.org> <20030112203150.GA53199@compsoc.man.ac.uk> <20030112210349.GA14612@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030112210349.GA14612@mars.ravnborg.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18XpVA-000CGN-00*gppITMZzmEc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 10:03:49PM +0100, Sam Ravnborg wrote:

> I would like to see it stay within the kernel for the following reasons:
> 1) It works as it is for those who have QT
> 2) It's more appealing to some people with a grapical frontend
> 3) If it fails, people can revert back to menuconfig
> 4) It does not take up much space. ~2 files
> 
> The problem seems that some people does not like the QT choice.
> But only one attemp has been made (that I know of) implementing
> an alternative graphical frontend. (Romain Lievin - GTK)
> 
> I you do not like the QT version - don't use it.
> If too many people post error - get it fixed.
> Simple...

I do not want it removed because it's a graphical frontend, or because
it's using Qt. I want it removed because it is an inappropriate package
to have it in.

All else being equal, code should not be in the kernel package. Please
explain the *advantages* of including it in the same package.

moc binary detection is broken, btw if the qt dir guessing is used (a
bad idea in the first place). That's just an obvious one, there are
undoubtedly other problems.

Sorry but it's just bizarre having patches for some GUI going through
lkml

regards
john
-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
