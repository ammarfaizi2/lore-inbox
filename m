Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbTEOL72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 07:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTEOL72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 07:59:28 -0400
Received: from fkn.j.pl ([80.48.48.38]:48782 "EHLO fkn.net.pl")
	by vger.kernel.org with ESMTP id S263980AbTEOL7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 07:59:25 -0400
Reply-To: <Marcin@MWiacek.com>
From: "Marcin Wiacek" <Marcin@MWiacek.com>
To: "'Lionel Bouton'" <Lionel.Bouton@inet6.fr>, <linux-kernel@vger.kernel.org>
Cc: <erwan@mas.nom.fr>
Subject: RE: [SiS IDE patch] various fixes
Date: Thu, 15 May 2003 14:09:38 +0200
Message-ID: <000601c31adb$2e8bf4f0$400063d9@marcin>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C31AEB.F214C4F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <3EBFA90F.8020802@inet6.fr>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C31AEB.F214C4F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

> here's a patch against 2.4.21-rc2-ac1 (applies cleanly on 2.4.21-rc2 
> too) which brings the following to the
> SiS IDE driver :
> - support for SiS655,
> - support for SiS630S/ET UDMA5 mode,
> - corrected /proc/ide/sis output for ATA133 chipsets (drives' 
> positions 
> were swapped),
> - use of pci_read_config instead of direct pci poking for 
> SiS962+ detection,
> I don't have the hardware for testing any of these changes, so SiS 
> owners, please test and report if you :
> - use an ATA133 chipset,
> - use a SiS630 (original, or SiS630S/ET).

I wanted to check if very carefully (Sis 655). DMA seems to be enabled
for HDD. But still there are some problems OR with 2.4.21 at all (I
quess something wrong generally in IDE support) OR still with Sis
driver. Why ? It seems, that DMA is NOT enabled for DVD and CDRW. I hear
it - they work very slow. Also hdparm shows errors, when get info about
them. In attachments examples.

Also there are some problems with Silicon Image driver (see
"DriveReadySeekCompleteError" in syslog). Because of it rather there is
problem with 2.4.21.

What can be done with it ? (both with enabling DMA for non HDD devices
and errors). If any of developers need something, please tell me.

Pozdrowienia/Best Regards
-- 
Marcin Wiacek (www.mwiacek.com marcin@mwiacek.com)

------=_NextPart_000_0007_01C31AEB.F214C4F0
Content-Type: application/octet-stream;
	name="LOGS.ZIP"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="LOGS.ZIP"

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

------=_NextPart_000_0007_01C31AEB.F214C4F0--

