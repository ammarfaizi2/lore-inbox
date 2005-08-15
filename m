Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVHOI2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVHOI2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHOI2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:28:04 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:39403 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932179AbVHOI2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:28:04 -0400
Date: Mon, 15 Aug 2005 10:28:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ARP finding procedure
Message-ID: <Pine.LNX.4.61.0508151025140.30634@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


I have multiple network cards (eth0-4) with all the same IP address 
(192.168.20.1) and mask (/16) assigned. I have observed upon pinging a 
yet-unknown address, e.g. .20.4, that the ARP-who-has queries are only sent 
out on eth0. I am pretty sure this is standard Linux behavior, so does anyone 
know how I can tune the kernel or its subsystems to send the ARP on all 
interfaces that match the route?



Jan Engelhardt
-- 
