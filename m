Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVCRKed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVCRKed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 05:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCRKed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 05:34:33 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53384 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261565AbVCRKe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 05:34:28 -0500
Date: Fri, 18 Mar 2005 11:34:19 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-net@vger.kernel.org,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 3c59x concerns on 2.4->2.6 update?
Message-ID: <20050318103418.GA14636@merlin.emma.line.org>
Mail-Followup-To: linux-net@vger.kernel.org,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently upgraded a router which has three 3Com900C Tornado cards
revisions 74 and 78 from Linux 2.4 to 2.6.

IIRC, Linux 2.4 allowed to report if the link beat was sensed to be 10
or 100 mbps, Linux 2.6 does not. One of these cards is attached to
peculiar network gear and needs to be forced to 100baseTx-FD.
I configured options=0x204 for that interface, which sorta worked;
vortex-diag and mii-diag still report autonegotiation were enabled.
Strange.

ethtool (I tried v2 and v3) does not appear to work at all for 3C900C
cards, "No data available" if run without options.

Any insight into these would be appreciated,

-- 
Matthias Andree
