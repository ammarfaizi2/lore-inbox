Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVCVHu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVCVHu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVCVHu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:50:57 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:35510 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262290AbVCVHuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:50:54 -0500
Date: Tue, 22 Mar 2005 08:51:16 +0100
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Voodoo 3 2000 framebuffer problem
Message-ID: <20050322075116.GC55@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    Linux Kernel 2.4.29, in a do-it-yourself linux box, equipped with
an AGP Voodoo 3 2000 card, tdfx framebuffer support. I boot in vga
mode 0x0f05, with parameter 'video=tdfx:800x600-32@100' and I get
(correctly) 100x37 character grid. All of that is correct. What is
not correct is the characters attributes, namely the 'blink'
attribute.

    If I use the tdfx framebuffer (I've tested some more
resolutions), I lose the blinking text (which I use, for example, for
marking my dangling symlinks in 'ls' or 'zsh'). Is this a bug, a
feature or just a mistake I'm consistently making?

    In addition to this, at boot time the background in the lines
around the cute penguin logo is white and not black as it should...

    Thanks a lot in advance. Feel free to ask for more details,
tests, etc.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
