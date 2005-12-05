Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVLEJ33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVLEJ33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 04:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVLEJ33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 04:29:29 -0500
Received: from odin2.bull.net ([192.90.70.84]:26758 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751359AbVLEJ32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 04:29:28 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org
Subject: APIC,  x86: How to change the IRQ of one board when BIOS can't ?
Date: Mon, 5 Dec 2005 10:34:46 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Message-Id: <200512051034.46954.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 05/12/2005 10:29:52,
	Serialize by Router on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 05/12/2005 10:29:59,
	Serialize complete at 05/12/2005 10:29:59
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get sometimes an APIC error on CPU 1. for IRQ 169, I get 4 modules : 3 USB 
and one Nvidia ( I know, you dislike that). I would like to affect another 
IRQ to the nvidia card to see if the problem is nvidia or not. I don't want 
to modify the others IRQ.
I can't from the BIOS. I red Documentation/i386/IO-APIC.txt but I'm not sure 
it is possible.
What is the best method to do that ? is pirq the solution ? how ?

