Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270280AbRHRSKF>; Sat, 18 Aug 2001 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270279AbRHRSJ6>; Sat, 18 Aug 2001 14:09:58 -0400
Received: from pop.gmx.de ([213.165.64.20]:23350 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S270280AbRHRSJn>;
	Sat, 18 Aug 2001 14:09:43 -0400
Message-ID: <001601c12810$f78ec040$0100005a@host1>
From: "peter k." <spam-goes-to-dev-null@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9: GCC 3.0 problem in "acct.c"
Date: Sat, 18 Aug 2001 20:09:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i just updated my gcc from 2.96 to 3.0.1 and now i cant compile kernel 2.4.9
anymore, make bzImage fails with the following error message:

acct.c: In function `check_free_space':
acct.c:147: Unrecognizable insn:
(insn 335 102 336 (parallel[
            (set (reg/v:SI 2 ecx [44])
                (const_int 0 [0x0]))
            (clobber (reg:CC 17 flags))
        ] ) -1 (insn_list:REG_DEP_ANTI 100 (insn_list:REG_DEP_ANTI 102
(nil)))
    (expr_list:REG_UNUSED (reg:CC 17 flags)
        (nil)))
acct.c:147: Internal compiler error in insn_default_length, at
insn-attrtab.c:223

can anyone tell me how to fix this?

thx


