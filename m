Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVCHCAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVCHCAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVCHCAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:00:40 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:23019 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261402AbVCHB5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 20:57:32 -0500
Date: Tue, 8 Mar 2005 02:57:31 +0100
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [announce 0/7] fbsplash - The Framebuffer Splash
Message-ID: <20050308015731.GA26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fbsplash - The Framebuffer Splash - is a feature that allows displaying
images in the background of consoles that use fbcon. The project is
partially descended from bootsplash. 

Unlike bootsplash, fbsplash has no in-kernel image decoder. Picture 
decompression is handled by a userspace helper which provides raw image 
data to the kernel. There is also no support for things like the silent 
mode and progress bars, as these are best handled by userspace programs. 

Truecolor, directcolor and pseudocolor modes are supported. Fbsplash has
no dependency on a specific framebuffer driver. It has been tested with
at least vesafb, rivafb and radeonfb.

Technical details about the userspace<->kernelspace interface can be 
found in patch 07/07, which contains the documentation.

The userspace utilities that make use of fbsplash can be found on:
http://dev.gentoo.org/~spock/projects/splashutils/

Live long and prosper.
-- 
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl



