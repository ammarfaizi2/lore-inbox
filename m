Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161550AbWHDWnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161550AbWHDWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161552AbWHDWnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:43:25 -0400
Received: from palrel12.hp.com ([156.153.255.237]:17388 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1161550AbWHDWnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:43:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17619.52619.386906.60775@cello.hpl.hp.com>
Date: Fri, 4 Aug 2006 15:43:23 -0700
From: Eric Anderson <anderse@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: result of pci=assign-busses on HP NW9440 laptop
X-Mailer: VM 7.15 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg on booting a 2.6.17.7 kernel on the HP NW9440 laptop reports:
 > PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
 > Please report the result to linux-kernel to fix this permanently

I'm not quite sure which part of the dmesg output I'm supposed to
report.  When I enable pci=assign-busses, the piece of dmesg that
reports the warning says nothing, but later on in dmesg where it is
printing out information about busses, it says:

 > PCI: Bus 6, cardbus bridge: 0000:05:06.0
 >   IO window: 00006000-000060ff
 >   IO window: 00006400-000064ff
 >   PREFETCH window: 88000000-89ffffff
 >   MEM window: 8a000000-8bffffff

Instead of PCI: Bus 3, ...

I didn't notice anything else changing.  If I should run some other
command or provide other output, tell me what to run and I'll report
the output.

Please CC me directly since I'm not subscribed to linux-kernel.
	-Eric


