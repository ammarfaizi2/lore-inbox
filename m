Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUKWODe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUKWODe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUKWOCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:02:04 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:16256 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261201AbUKWOA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:00:26 -0500
Date: Tue, 23 Nov 2004 14:00:25 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Running Ethernet without ARP
Message-ID: <20041123140025.GA32447@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

man netdevice says:
"IFF_NOARP	No arp protocol, L2 deswtination address not set".
Is it possible to run ptp Ethernet link between two Linux routers this
way? I would like to run the link with two constraints:
1) no ARP protocol used
2) The link should continue to work even if root access to one computer is
inaccessible and the NIC in the other one is replaced without changing it's MAC
(for example because it doesn't support MAC change)

Cl<
-- 
Thanks to all free technology developers for the things they are making
available to general public. Free technology includes free software.
