Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTKPQKj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 11:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbTKPQKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 11:10:39 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:27878 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262925AbTKPQKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 11:10:34 -0500
Subject: Measuring per thread CPU consumption & others statistics for NPTL
From: Peter Zaitsev <peter@mysql.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MySQL
Message-Id: <1068997909.2276.64.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 19:10:25 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel developers,

I would wish to add to MySQL profiling of CPU and system usage, which
would allow for example to see amount of system/user CPU needed to
process particular query as well as amount of IO needed.

With LinuxThreads I probably can use times() or getrusage() for this
purpose, as Threads share a lot of infrastructure with processes. 

This however would not work with NPTL threads.


Are there any ways to get similar information for thread rather than
process ?

Second question is about accuracy -  Is any way to get system/user CPU
consumption information with more than 1/100 sec accuracy ?

Thank you for your advices.

-- 
Peter Zaitsev, Full-Time Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification

