Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWCVXAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWCVXAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWCVXAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:00:19 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:40669 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1751138AbWCVXAR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:00:17 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI error in 2.6.16
Date: Wed, 22 Mar 2006 23:59:55 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603222359.55631.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sometimes at boot I get the following from the logs:

ACPI: write EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for 
[EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed 
[\_SB_.PCI0.ISA_.EC0_.SMRD] (Node c13ecd40), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.UPBI] 
(Node dbf42720), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.BAT1.CHBP] 
(Node dbf42660), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed 
[\_SB_.PCI0.ISA_.EC0_.SMSL] (Node c13ecce0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed 
[\_SB_.PCI0.ISA_.EC0_._Q09] (Node c13ecc40), AE_TIME

And after that the battery is reported as absent (even if it is physically 
present). I get the impression that this happens when rebooting, not 
from "cold powerons".

This did not happen in 2.6.15, it appeared somewhere in 2.6.16-rc series.

Regards,

  Francesco

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
