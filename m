Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbULGA3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbULGA3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbULGA3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:29:23 -0500
Received: from imo-d01.mx.aol.com ([205.188.157.33]:927 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S261711AbULGA3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:29:21 -0500
Date: Mon, 06 Dec 2004 19:29:18 -0500
From: FoObArf00@netscape.net
To: linux-kernel@vger.kernel.org
Subject: IGMP packets?
MIME-Version: 1.0
Message-ID: <123E01F1.3018C387.023DF18B@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 66.146.57.210
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to analyze igmp packets (queries, reports) with ttl of 1 ,of course, in the kernel and ran into a weird situation.  Only when an interface is in promiscuous mode (i.e. tcpdump), the igmp packets get to ip_rcv on ip_input.c.  I was wondering if someone can point in the right direction on how/where to get the these packets when not doing a tcpdump.  Thanks 

__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp
