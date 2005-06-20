Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVFTSvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVFTSvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVFTSvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:51:25 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:16914 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S261446AbVFTSvV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:51:21 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAA60@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: =?UTF-8?B?J1BldHRlciBTdW5kbMO2Zic=?= 
	<petter.sundlof@findus.dhs.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Observation: very low USB performance in 2.6.12 (-2 from agnu
	la)
Date: Mon, 20 Jun 2005 13:46:43 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the things I have recently fought with on 2.6.12 is a soft-lockup
exception with enabling "Legacy USB Support" in the BIOS. Apparently this
problem will cause the 2005.0 installation CD for x86_64 to HANG on USB Mass
Storgae detect unless the "nousb" option is set at boot. The Legacy USB
feature also causes Oops on bootup unless Disabled. I am running dual
Opteron 240 1G ram with ASUS K8N-DL MB (Nforce 4).

-----Original Message-----
From: Petter Sundlöf [mailto:petter.sundlof@findus.dhs.org]
Sent: Monday, June 20, 2005 1:14 PM
To: Linux Kernel Mailing List
Subject: Observation: very low USB performance in 2.6.12 (-2 from
agnula)


I've observed that USB performance (mass storage) is severaly degraded 
in 2.6.12. Going back to 2.6.10 restores performances to expected levels.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
