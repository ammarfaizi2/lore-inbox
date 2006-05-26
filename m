Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWEZVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWEZVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWEZVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:22:55 -0400
Received: from mx.freeshell.ORG ([192.94.73.18]:3032 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S1751579AbWEZVWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:22:55 -0400
Date: Fri, 26 May 2006 21:22:43 +0000
From: Aravind Gottipati <aravind@freeshell.org>
To: linux-kernel@vger.kernel.org
Subject: e1000 poor network performance - 2.6.17-rc5-g705af309
Message-ID: <20060526212243.GA19250@SDF.LONESTAR.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently started running linux on a new x60 thinkpad and started
noticing really poor network performance with this kernel.  I saw some
archived threads from a while back saying this could be related to
conntracking.  Disabled that (rmmod ip_conntrack) did not fix the
problem.  I also tried disabling tso but that didn't have any effect
either.  I can reproduce the problem when connected to a 100Mbps switch
(I don't have a GigE network to test this with).

This laptop uses the Intel 82573L (PCI-Express) chip.  I'd be glad to
assist with any toubleshooting/testing w.r.t this.  I am not subscribed
to the list, so please cc me on any replies.

Thank you,

Aravind.
