Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUDPFIC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUDPFIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:08:02 -0400
Received: from magic.adaptec.com ([216.52.22.17]:15247 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262244AbUDPFIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:08:00 -0400
Date: Fri, 16 Apr 2004 10:41:35 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: linux-kernel@vger.kernel.org
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
Subject: How does ioremap() get non-cached mappings
Message-ID: <Pine.LNX.4.44.0404161037130.17679-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Apr 2004 05:07:57.0344 (UTC) FILETIME=[C8167200:01C42370]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap() function in x86 arch code does not seem to be setting _PAGE_PCD 
bit in the PTE. How then does it give non-cached mapping to MMIO mappings 
for memory on some interface card. I have gone thru some old threads on 
this, which have concluded that it does give non-cached mappings, and 
moerover ioremap seems to work fine whenever I have used to map any PCI 
card memory,
Is it guaranteed thru the means of MTRR ?


Thanx,
tomar


-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

