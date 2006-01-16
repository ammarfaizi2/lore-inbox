Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWAPIrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWAPIrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWAPIrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:47:18 -0500
Received: from outmx017.isp.belgacom.be ([195.238.4.116]:45528 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932249AbWAPIrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:47:18 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.15] screen remains blank after LID switch use
Date: Mon, 16 Jan 2006 09:46:51 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601160946.51765.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I have no idea who the maintainer for this is, I was unable to find any entry 
in the MAINTAINERS file.. if i overlooked it, feel free to correct me)

Hello list,


I've recently gotten an Dell D610 laptop from my company. After some digging I 
managed to get Linux running on it, with kernel 2.6.15 at this moment.

There is something odd going on with the LID switch functionality tho: 
everytime the LID is closed, the screen goes off, as expected. Unfortunately, 
the screen does not come back alive afterwards, it remains blank.

Starting X doesn't help, switching consoles doesn't help either. The problem 
is appareant both in X and the console.

The laptop remains completely functional, except for the display.

Currently I'm not using a fb console, and the X driver is the i810.

Any ideas?

Thanks,

Jan
-- 
This is NOT a repeat.
