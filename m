Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317651AbSGZKvH>; Fri, 26 Jul 2002 06:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSGZKvH>; Fri, 26 Jul 2002 06:51:07 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:46235 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317651AbSGZKvG>; Fri, 26 Jul 2002 06:51:06 -0400
Date: Fri, 26 Jul 2002 11:54:21 +0100 (BST)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@gerber
To: linux-kernel@vger.kernel.org
Subject: Something else broke between -rc2 and -rc3?
Message-ID: <Pine.GSO.4.44.0207261146270.25223-100000@gerber>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys - for the last week, I've been running 2.4.19-rc2 (with the "hacky"
Athlon/AGP cache coherency fix) and it's the _only_ kernel to have
worked properly on my machine. BTW, I also added the latest O(1)
scheduler patch, but nothing else.

I use the Nvidia driver for my sins, and it triggers the Athlon "issue".
Hacky or not, -rc2 seemed to finally fix the problem, because my box
survived 6 days of relative torture, which it's _never_ got close to
before.

Being the obsessive upgrader that I am, I then built -rc3 with the same
config. Bang, the box didn't even survive 12 quiet hours. Seeing as
there are few changes between -rc2 and -rc3 (though there is something
in the AGP backend somewhere), what could cause this?

[ Machine is Athlon XP 1800+ / Via KT266A / IDE / Red Hat 7.3 ]

Cheers
Alastair                            .-=-.
__________________________________,'     `.
                                           \   www.mrc-bsu.cam.ac.uk
Alastair Stevens, Systems Management Team   \       01223 330383
MRC Biostatistics Unit, Cambridge UK         `=.......................

