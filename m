Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTH0VaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTH0VaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:30:10 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:17802 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262263AbTH0VaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:30:08 -0400
Date: Wed, 27 Aug 2003 17:27:32 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: lost socket
Message-ID: <Pine.GSO.4.33.0308271658370.7750-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would appear the kernel is not properly reporting all the active sockets.
I noticed this in 2.5.70 while checking netflow collection... udp port 9800
is bound and actively receiving traffic, however, nothing reports it's
existance.  2.6.0-test4 still has this bug.

This smells like a simple "off by one" bug, but I've been too busy to go
look at the code.

--Ricky


