Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRAYRpi>; Thu, 25 Jan 2001 12:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132699AbRAYRp2>; Thu, 25 Jan 2001 12:45:28 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:10956 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132577AbRAYRpT>;
	Thu, 25 Jan 2001 12:45:19 -0500
Date: Thu, 25 Jan 2001 18:45:16 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101251745.SAA07063@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: x86 PAT errata
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before people get too exited about the x86 Page Attribute Table ...
Does Linux use mode B (CR4.PSE=1) or mode C (CR4.PAE=1) paging?
If so, known P6 errata must be taken into account.
In particular, Pentium III errata E27 and Pentium II errata A56
imply that only the low four PAT entries are working for 4KB
pages, if CR4.PSE or CR4.PAE is enabled.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
