Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUEMPDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUEMPDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUEMPDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:03:07 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:8913 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264244AbUEMPDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:03:05 -0400
Subject: Re: oops ACPI in Linux-2.6.6-bk1
From: Pat LaVarre <p.lavarre@ieee.org>
To: kernelnewbies@nl.linux.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1084375733.3077.2.camel@patibmrh9>
References: <1084375733.3077.2.camel@patibmrh9>
Content-Type: text/plain
Organization: 
Message-Id: <1084460558.5303.39.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2004 09:02:38 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2004 15:03:01.0853 (UTC) FILETIME=[62C968D0:01
	C438FB]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:18.38057 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: Subsystem revision 20040326 ...
> [<c01eef72>] acpi_ev_save_method_info+0x44/0x75 ...
> Unable to handle kernel NULL pointer dereferencec01e1194 ...
> Kernel panic: Aiee, killing interrupt handler! ...
> Unable <o ha1dleUn kernel NULL pointer dereferenceer dereferenceOoops: ...
> Unable to handle kernel NULL pointer dereference at virtual address ...

Theory confirmed:

Deleting CONFIG_ACPI=y etc. via `make xconfig` fixes this.

Pat LaVarre


