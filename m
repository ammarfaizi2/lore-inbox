Return-Path: <linux-kernel-owner+w=401wt.eu-S932859AbXAACAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859AbXAACAq (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 21:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbXAACAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 21:00:46 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34546 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932859AbXAACAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 21:00:45 -0500
Date: Mon, 1 Jan 2007 03:00:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Netfilter Mailing List <netfilter@lists.netfilter.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: chaostables 0.2
Message-ID: <Pine.LNX.4.61.0701010248480.29991@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list(s),



chaostables is a small package containing some nice netfilter magic:
a module xt_portscan which matches the nmap scan types (including -sS) 
and more, and a xt_CHAOS module which slows down network scanners by 
triggering their codepaths for handling slow-working/'broken' operating 
systems.

Documentation is not yet fully complete, but it explains the details 
behind the portscan match and how it can be implemented without using 
the xt_portscan.ko module. By looking at the code and some example 
files, it should be possible to figure out how to use these (obviously, 
-m portscan [types] and -j CHAOS -- but a little self-experimenting is 
always good, too.)

http://jengelh.hopto.org/f/chaostables/chaostables-0.2.tar.bz2
(it is a remake of what was previously known, and now inaccessible, as 
AS_IPFW)

I happily take comments on anything.

Thanks and, FWIW, happy  new Year(),
Jan
-- 
