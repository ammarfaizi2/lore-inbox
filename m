Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265077AbUFAOEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265077AbUFAOEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFAOEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:04:16 -0400
Received: from main.gmane.org ([80.91.224.249]:5004 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265065AbUFAOAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:00:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gabriel Ebner <ge@gabrielebner.at>
Subject: Re: 2.6.7-rc2-mm1
Date: Tue, 01 Jun 2004 15:58:19 +0200
Message-ID: <1763198.2IkDi1GkbE@schnecke2.gabrielebner.at>
References: <20040601021539.413a7ad7.akpm@osdl.org> <15751764.P3t0zfFIzn@schnecke2.gabrielebner.at> <20040601110532.GE25943@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello212186175067.4.14.vie.surfer.at
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrey Panin wrote:
> Try the attached patch, it should fix DMI related problem.

Yes, it fixes most of the DMI related problems, some persist however:

  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x4236): In function
`dmi_disable_acpi':
: undefined reference to `acpi_force'
arch/x86_64/kernel/built-in.o(.init.text+0x42a7): In function
`force_acpi_ht':
: undefined reference to `acpi_force'
arch/x86_64/ia32/built-in.o(.data+0x898): In function `ia32_sys_call_table':
: undefined reference to `compat_get_mempolicy'
make: *** [.tmp_vmlinux1] Fehler 1

        Gabriel.

-- 
Gabriel Ebner - reverse "ta.renbeleirbag@eg"

