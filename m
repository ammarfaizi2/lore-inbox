Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282400AbRLICgW>; Sat, 8 Dec 2001 21:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282393AbRLICgM>; Sat, 8 Dec 2001 21:36:12 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:9702 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S282392AbRLICf6>; Sat, 8 Dec 2001 21:35:58 -0500
Date: Sat, 8 Dec 2001 21:33:57 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: DMA failure to pages w/ addr under 64meg
Message-ID: <Pine.LNX.4.20.0112082130160.12906-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 What could cause a DMA transfer to a page with physical address below
64mb to fail ?

 Context: I am using rvmalloc code from bt848 driver in video capture
module (km, http://www.sf.net/projects/gatos). The device that does the
transfer is AGP videocard (Radeon), transfer from device to main memory.

All transfers to pages with physical addresses below fail consistently.

                  thanks !

                     Vladimir Dergachev

