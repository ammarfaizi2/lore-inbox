Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSLaPcF>; Tue, 31 Dec 2002 10:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSLaPcF>; Tue, 31 Dec 2002 10:32:05 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:7942 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S263333AbSLaPcE>; Tue, 31 Dec 2002 10:32:04 -0500
Date: Tue, 31 Dec 2002 15:40:24 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: analysing crash dumps
Message-ID: <Pine.LNX.4.44.0212311530580.12063-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'd appreciate any advice on how one would go about analysing a core 
dump of a crashed machine, eg as obtained via netdump.

I'm trying to pin down some kind of timing problem with a driver,
which i've determined from NMI handler forced Oops() is getting stuck
spinning in its interrupt handler. However, i'd like to try see if i 
can pull any information about its state from the core dump.

gdb doesnt seem happy with the stack (kernel is compiled without frame 
pointers, no?), 'bt' and 'frame' commands dont really do anything 
useful.

so any advice / pointers to good docs on how to analyse a netdump 
would be much appreciated.

thanks,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

