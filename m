Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbSLKOp7>; Wed, 11 Dec 2002 09:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267177AbSLKOp7>; Wed, 11 Dec 2002 09:45:59 -0500
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:36071 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S267174AbSLKOp4>; Wed, 11 Dec 2002 09:45:56 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Framebuffer problems, 2.4.20-rc2, 2.5.51
Date: Wed, 11 Dec 2002 09:55:39 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212110955.39586.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:
00:0a.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 
5c)

01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti200] 
(rev a3)

Using ATYFB with CONFIG_FB_ATY, CONFIG_FB_ATY_CT and RIVAFB

2.4.20-rc2:
	Kernel freezes upon loading the ATYFB driver.
	No error messages.Sysrq has no effect. 
	Riva framebuffer alone works.
	

2.5.51:
	Kernel freezes upon loading the ATYFB driver.
	No error messages. Sysrq has no effect.
	
	Riva (tested without atyfb) shows a black screen, apparently
	followed by a kernel freeze since Sysrq has no effect.
	
	Kernel without boots without framebuffer, so the framebuffer causes the 
freeze.

==================================






	
	
