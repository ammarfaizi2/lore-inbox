Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVCGXL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVCGXL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCGXAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:00:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:20125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261870AbVCGW1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:27:06 -0500
Date: Mon, 7 Mar 2005 14:26:58 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Wrong Bogomips on G4 iBook?
Message-ID: <20050307142658.130fc4c9@es175>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Started running on a G4 iBook, and noticed the bogomips do not look right.
~$ cat /proc/cpuinfo
processor       : 0
cpu             : 7447A, altivec supported
clock           : 1333MHz
revision        : 1.2 (pvr 8003 0102)
bogomips        : 663.55
machine         : PowerBook6,5
motherboard     : PowerBook6,5 MacRISC3 Power Macintosh 
detected as     : 287 (iBook G4)
pmac flags      : 0000001b
L2 cache        : 512K unified
memory          : 768MB
pmac-generation : NewWorld

I see the with kernels 2.6.9 and greater.  Is this a problem, or just an artifact? 
More details on request. 
cliffw


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
