Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRL1VLG>; Fri, 28 Dec 2001 16:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRL1VK5>; Fri, 28 Dec 2001 16:10:57 -0500
Received: from pc26.tromso2.avidi.online.no ([148.122.16.26]:28939 "EHLO
	shogun.thule.no") by vger.kernel.org with ESMTP id <S278701AbRL1VKp>;
	Fri, 28 Dec 2001 16:10:45 -0500
From: "Troels Walsted Hansen" <troels@thule.no>
To: "'Andreas Hartmann'" <andihartmann@freenet.de>,
        "'Kernel-Mailingliste'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.18-pre1
Date: Fri, 28 Dec 2001 22:10:36 +0100
Message-ID: <000e01c18fe4$1b0f7d80$0300000a@samurai>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <3C2CCB82.7010309@athlon.maya.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - Update Athlon/VIA PCI quirks			(Calin A.
>I tested this patch and unfortunately, I have to say, it is not working
(if it should prevent the 
>suddenly changing time on VIA-boards). I have the same problem with
suddenly changing time as 
>without this patch.

Nope, the change is related to a bug in the VIA Northbridge memory write
queue timer causing oopses on Athlon optimised linux kernels.

I believe the patch you're looking for is last seen in the ac series,
and not merged with 2.4 mainline due to triggering on unaffected
motherboards.

-- 
Troels Walsted Hansen


