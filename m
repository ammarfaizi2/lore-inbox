Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280257AbRLDC43>; Mon, 3 Dec 2001 21:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282185AbRLCXsV>; Mon, 3 Dec 2001 18:48:21 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:14042 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S284515AbRLCMgL>; Mon, 3 Dec 2001 07:36:11 -0500
Date: Mon, 3 Dec 2001 13:36:04 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: misc_cache_init
Message-ID: <Pine.LNX.4.33.0112031324470.19914-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I looked at some past kernel mailings and it seems like some archs need 
specific caches and others don't. In order to provide these 
functionalities I suggest to add somewhere to init/main.c
	misc_cache_init();
and provide an initial
	#define misc_cache_init() do {} while (0)
for every architecture.
Anyone agrees on this?

Frank.

