Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUFAQBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUFAQBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUFAQBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:01:19 -0400
Received: from main.gmane.org ([80.91.224.249]:12943 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264904AbUFAQBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:01:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gabriel Ebner <ge@gabrielebner.at>
Subject: Re: 2.6.7-rc2-mm1
Date: Tue, 01 Jun 2004 17:58:46 +0200
Message-ID: <2801394.4xBL5sa4j5@schnecke2.gabrielebner.at>
References: <22dBi-3Hb-27@gated-at.bofh.it> <22exj-4ty-15@gated-at.bofh.it> <22fjG-56P-11@gated-at.bofh.it> <22i80-7v8-41@gated-at.bofh.it> <m34qpvjog0.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello212186175067.4.14.vie.surfer.at
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andi Kleen wrote:
> This patch should fix it.
> 
> -------------------------------------------------------------
> 
> Fix compilation of x86-64 with NUMA off

Thanks Andi, that fix fixed 1 error, so 2 still remain:

  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x4236): In function
`dmi_disable_acpi':
: undefined reference to `acpi_force'
arch/x86_64/kernel/built-in.o(.init.text+0x42a7): In function
`force_acpi_ht':
: undefined reference to `acpi_force'
make: *** [.tmp_vmlinux1] Fehler 1

        Gabriel.

-- 
Gabriel Ebner - reverse "ta.renbeleirbag@eg"

