Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSGUXbH>; Sun, 21 Jul 2002 19:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGUXbG>; Sun, 21 Jul 2002 19:31:06 -0400
Received: from fusion.wineasy.se ([195.42.198.105]:39428 "HELO
	fusion.wineasy.se") by vger.kernel.org with SMTP id <S315214AbSGUXbG>;
	Sun, 21 Jul 2002 19:31:06 -0400
Date: Mon, 22 Jul 2002 01:34:10 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: linux-kernel@vger.kernel.org
Subject: using bitkeeper to backport subsystems?
Message-ID: <20020721233410.GA21907@lukas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use/track the linuxconsole project (especially for its
Multi-desktop operation), which tracks 2.5 on the stable tree
2.4.

is bitkeeper the easiest way to go? i imagine the patch sets to
be like transformations, which can be superimposed, so i would
clone marcellos and linus tree, generate a linuxconsole patchset
against linus tree and backport it to marcellos tree. (there are
older backports, which should make my live easier.) 

I imagine that i had two 'transforms' now: first the linuxconsole
transform, which changes over time as the project (and the
kernel) moves on, and the backport transform, which i hope to
remain more static. Can i superimpose these transforms? Is this
how it works?

has anyone done this before? is there a howto or could someone
outline the bitkeeper steps needed? Any catches?
