Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUCWK7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUCWK7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:59:16 -0500
Received: from math.ut.ee ([193.40.5.125]:13733 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262459AbUCWK7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:59:16 -0500
Date: Tue, 23 Mar 2004 12:59:13 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: netfilter strange linker error message
Message-ID: <Pine.GSO.4.44.0403231256530.11561-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is todays 2.6.5-rc2+BK snapshot.

  CC [M]  net/ipv4/netfilter/ip_nat_standalone.o
ld: cannot open linker script file net/ipv4/netfilter/.tmp_ip_nat_standalone.ver: No such file or directory

The compilation continues. Rerunning make doesn't emit any messages
about this. Debian unstable, up to date, x86.

-- 
Meelis Roos (mroos@linux.ee)

