Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSKMTZ4>; Wed, 13 Nov 2002 14:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSKMTZz>; Wed, 13 Nov 2002 14:25:55 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18450 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S262604AbSKMTZw>; Wed, 13 Nov 2002 14:25:52 -0500
Date: Wed, 13 Nov 2002 14:32:27 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: make distclean and make dep??
Message-ID: <Pine.LNX.4.44.0211131417480.32544-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do a "make distclean" in a tree, should not that roll it back to a 
clean empty tree? I noticed that when I did that no work was done by "make 
dep" in the rebuild.

Distclean is supposed to be even cleaner than mrproper (to build a clean
tree for distribution) and this behaviour is new.

Also noted, somewhere between 2.5.45 and 2.5.46 distclean vanished from 
"make help." It's really useful to have distclean work to build patched 
kernels for distribution, hopefully this is an oversight and not a new 
policy.

Obviously I can delete modversions.h by hand.

--
bill davidsen <davidsen@tmr.com>

