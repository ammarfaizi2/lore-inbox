Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWAHWYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWAHWYD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWAHWYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:24:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30597 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964965AbWAHWYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:24:02 -0500
Date: Sun, 8 Jan 2006 23:24:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: reiserfs mount time
Message-ID: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


brought to attentino on an irc channel, reiser seems to have the largest 
mount times for big partitions. I see this behavior on at least two 
machines (160G, 250G) and one specially-crafted virtual machine
(a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).
Here's a dig http://linuxgazette.net/122/misc/piszcz/group001/image002.png 
from http://linuxgazette.net/122/TWDT.html#piszcz
So, any hint from the reiserfs developers how come reiserfs takes so long?
Standard mkreiserfs options (none extra passed).


Jan Engelhardt
-- 
