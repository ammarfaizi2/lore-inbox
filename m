Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUA1NfC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUA1NfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:35:01 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:58100 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265956AbUA1Ney (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:34:54 -0500
Date: Wed, 28 Jan 2004 14:34:43 +0100
From: Michelle Konzack <linux4michelle@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: "kernel Bug at checkpoint.c: 587!" (2.4.22)
Message-ID: <20040128133443.GE26631@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings MIchelle.
X-Disclaimer-1: Eine weitere Verwendung oder die Veroeffentlichung
X-Disclaimer-2: dieser Mail oder dieser Mailadresse ist nur mit der
X-Disclaimer-3: Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux michelle1 2.4.22-vectra-work
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I am using Debian GNU/Linux 3.0r2 with a self compiled 2.4.22 Kernel.

Since I have compiled a new Kernel for my ADSL-Router sometimes 
i get the 'kernel Bug at checkpoint.c: 587!'

------------------------------------------------------------------------
Assertion failure in __journal_drop_transaction() at checkpoint.c:587: "transact
ion->t_ilist == NULL"
kernel Bug at checkpoint.c: 587!
invalid operand: 0000
CPU:    0
EIP:    0010:[<0015b094>]   Not tainted
EFLAGS: 00010286
eax: 00000069   ebx: c04ff120   ecx: c10ac000   edc: 00000000
esi: c10d6c00   edi: c04ffa20   ebp: c194db50   esp: c10ade60
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 7, stackpage:c10ad000)
Stack: c01fb500 c01fb7a1 c01fb4e1 0000024b c01fb784 c1e15190 c015af42 c10d6c00
       c04ff120 c109c720 c1e15190 c0159af6 c1e15190 c10d6c50 c10d6c50 c10d6c00
       00000000 c10d6c94 c04ffa74 c10d6c50 00000000 0000034c c113f0b4 00000000
Call Trace:    [<c015af42>] [<c0159af6>] [<c010fd36>] [<c015be08>] [<c015bc70>]
  [<c0105550>]

Code: 0f 0b 4b 02 e1 b4 1f c0 83 c4 14 90 83 7b 1c 00 74 2a 68 c0
------------------------------------------------------------------------

Since it has somthing to do with the ext3 filesystem I have used 
fsck.ext3 to determine whats going on. - negativ, no errors. 

Now I have booted the bf24 Kernel (2.4.18) and it works without any 
problems...

If you need my System.map (457.639 Bytes) let me know.

Greetings
Michelle

-- 
Registered Linux-User #280138 with the Linux Counter, http://counter.li.org/ 
