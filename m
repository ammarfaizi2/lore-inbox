Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268905AbRHBMXe>; Thu, 2 Aug 2001 08:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268908AbRHBMXZ>; Thu, 2 Aug 2001 08:23:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30224 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268905AbRHBMXN>; Thu, 2 Aug 2001 08:23:13 -0400
Subject: Re: SMP possible with AMD CPUs?
To: pgallen@randomlogic.com (Paul G. Allen)
Date: Thu, 2 Aug 2001 13:24:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <no.id> from "Paul G. Allen" at Aug 01, 2001 06:55:21 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SHX2-0000SZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	a. The IDE is no longer a 7409 PCI ID but 7411 so it operates as a generic IDE (slow as hell).
[Should run full UDMA in -ac]

> 	b. The AGP is now ID 700C and is not detected unless the agpgart driver is loaded with agp_try_unsupported=1.

Send me the relevant pci idents and I'll add it

> 	d. The PCI bridge ID is different and (again) operates in a generic modeAgain send me the ids
> 	e. The Host bridge ID is now 700C and operates in a generic mode.

Send me the idents for these two

> 3. The BIOS (apparently) doesn't setup the MTRR properly on both CPUs making mtrr bitch about a mismatch.

The mtrr driver fixups should cure that - its a common bios bug.

Alan
