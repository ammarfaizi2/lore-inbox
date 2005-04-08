Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVDHVa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVDHVa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVDHVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:30:56 -0400
Received: from [83.246.78.200] ([83.246.78.200]:36803 "EHLO
	srvh02.vc-server.de") by vger.kernel.org with ESMTP id S261151AbVDHVao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:30:44 -0400
Date: Fri, 08 Apr 2005 21:32:45 +0000
From: Dennis Heuer <dh@triple-media.com>
Subject: A way to smoothly overgive graphics control to an other
 process/program
To: linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.2.5
Message-Id: <1112995965l.18701l.3l@Foo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srvh02.vc-server.de
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - triple-media.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I feel disturbed by the fact that when display-controlling programs are started in line (like the bootloader, linux, and finally xdm/gdm/kdm), there appear several switches of display resolution, text- and graphics mode, and background images. I asked myself how to get that more smooth as if there was only one presentation from the time the bootloader started up to the gnome/kde session. I thought that one could implement a small api that allows a running process to freeze display updates until the next process has overtaken the display, loaded the same presentation (from same location or just by similar configuration), dumped it to the working buffer of the graphics card, and released the display (a timeout with fallback-mode could make this transaction more fault-resistent). This way, the image loaded by the bootloader could be held on display up to the graphical login, and even as the desktop background, without any visible effect.

Is this technically feasible?

Regards

Dennis Heuer

