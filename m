Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUDASBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUDASBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:01:01 -0500
Received: from imail1.gazeta.pl ([193.42.231.143]:59793 "EHLO imail1.gazeta.pl")
	by vger.kernel.org with ESMTP id S263007AbUDASA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:00:59 -0500
Message-ID: <1080842398622.ew4.tbeg@gazeta.pl>
Date: Thu, 1 Apr 2004 19:59:58 +0200 (CEST)
From: <tbeg@gazeta.pl>
To: linux-kernel@vger.kernel.org
Subject: Max size of buffer shared between kernel and user application?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-mailer: (c)Agora mailer (v3.00)
Organization: Portal Agory S.A.
X-IP: jupiter.adlex.com
X-Complaints-To: abuse@gazeta.pl
X-URL: http://www.gazeta.pl
X-Smite-Info: SmiteCRC Jan 10 2004
X-SpamDetect: *: 1.500000 Invalid Pairs=1.0,From: does not include a real name=0.5
X-Smite-CRC: A#K542L6#Ij8R58#16zA4uA#15ovNzS$147Oo3L$mwfkuQ#1scGA3R#1CjTLhW$BC1aq1
X-External-IP: 172.20.26.234
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the maximum size of a memory region mapped with a ioremap().
I 'm writing a driver that will share a buffer with an application
mapping the same phys mem region using ioremap() in kernel and
mmap(/dev/mem) in the application. I'm using a Linux 2.4.18 on a HP
server with 4GB RAM.

Tomek

