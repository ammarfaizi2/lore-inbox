Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318861AbSG0XyK>; Sat, 27 Jul 2002 19:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318863AbSG0XyK>; Sat, 27 Jul 2002 19:54:10 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:58532 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S318861AbSG0XyK>;
	Sat, 27 Jul 2002 19:54:10 -0400
Date: Sun, 28 Jul 2002 01:57:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux-2.5.28
Message-ID: <20020727235726.GB26742@win.tue.nl>
References: <1027553482.11881.5.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 06:08:48PM -0700, Linus Torvalds wrote:

> Most of the IDE stuff is FUD and misinformation. I've run every single
> 2.5.x kernel on an IDE system ("penguin.transmeta.com" has everything on
> IDE), and the main reported 2.5.27 corruption was actually from my BK tree
> apparently due to the IRQ handling changes.

Linus, Linus, how can you say something so naive?
I need not tell you that one user without problems does not imply
that nobody will have problems.

A few people reported lost filesystems. Many more reported mild
filesystem damage. And now you also report mild filesystem damage.

FUD? Fear? Yes, the fear is justified for whoever does not have backups.
Uncertainty? Yes, when the filesystem is damaged again, it is not quite
clear what causes it. Doubt? Yes, many people doubt whether they can
afford to run 2.5.recent.

This evening I ran vanilla 2.5.29 and was rewarded with mild filesystem damage.
91 files in /lost+found. Nothing. A few kernel versions ago it was three
orders of magnitude worse.

IDE? 2.4.17 and 2.5.27+Jens are stable for me in ordinary use.
IRQ? Quite possible.
My third candidate is USB. Systems without USB are clearly more stable.

Andries
