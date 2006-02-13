Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWBMBJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWBMBJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWBMBJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:09:29 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:26073 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751513AbWBMBJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:09:28 -0500
Date: Mon, 13 Feb 2006 02:09:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] hrtimer patches
Message-ID: <Pine.LNX.4.61.0602130153230.30994@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here a few patches to cleanup and fix a few things in the hrtimer. It's 
mainly aimed at keeping older hardware working reasonably, especially the
get_time() call can be rather expensive, so let's try to avoid it where 
possible.
This is the minimum amount of patches I'd like to see for 2.6.16. There a 
few other cleanups possible, but that can be done later.

bye, Roman
