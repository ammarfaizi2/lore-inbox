Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTDGEMd (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 00:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTDGEMd (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 00:12:33 -0400
Received: from [210.22.78.238] ([210.22.78.238]:47327 "HELO trust-mart.com")
	by vger.kernel.org with SMTP id S263229AbTDGEMc (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 00:12:32 -0400
From: hv <hv@trust-mart.com.cn>
To: linux-kernel@vger.kernel.org
Subject: compile error with 2.5.66-ac2
Message-Id: <20030407122310.22b2023a.hv@trust-mart.com.cn>
Organization: it-TM
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 7 Apr 2003 00:12:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  When I compile 2.5.66-ac2 on HP LH6000,I get the follow error:
arch/i386/kernel/apic.c: In function `setup_local_APIC':
arch/i386/kernel/apic.c:454: unrecognizable insn:
(insn 541 1623 1624 (set (strict_low_part (reg:QI 2 cl [58]))
        (const_int 0 [0x0])) -1 (insn_list:REG_DEP_OUTPUT 530 (nil))
    (nil))
arch/i386/kernel/apic.c:454: Internal compiler error in insn_default_length, at
insn-attrtab.c:356
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[1]: *** [arch/i386/kernel/apic.o] Error 1
make: *** [arch/i386/kernel] Error 2

My linux is redhat8.0
