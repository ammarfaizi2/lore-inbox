Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268061AbUHaMLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268061AbUHaMLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUHaMLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:11:46 -0400
Received: from pop.gmx.de ([213.165.64.20]:61645 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268061AbUHaMLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:11:16 -0400
Date: Tue, 31 Aug 2004 14:11:11 +0200 (MEST)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary173451093954271"
Subject: [patch-utility] remove whitespaces from kernel sources (for any kernel version)
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <17345.1093954271@www23.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary173451093954271
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

the attached shell skript recursively removes
any trailing spaces and tabs from c and h files.

for current 2.6.x kernel a resulting diff had a size
of about 24 MB unpacked. i suppose that other kernel
trees will compare to this magnitude.

this means the linux kernel source has an interesting potential
for optimisation which will result in smaller tarballs,
faster compilation in misc stages of code preprocessing
and last but not least lesser fuzz in diffs for people
that do use editors which will strip such charcters by themselves.

please note that i did not use the [[:space:]] qualifier in the script
since that would strip the intentional <Form-Feed> chars as well.

i would enjoy if you could apply those patch to your kernel source.

-Alex.

PS: please CC me on replys since i am not subscribed to this list

-- 
Supergünstige DSL-Tarife + WLAN-Router für 0,- EUR*
Jetzt zu GMX wechseln und sparen http://www.gmx.net/de/go/dsl
--========GMXBoundary173451093954271
Content-Type: application/octet-stream; name="strip_spc_r"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="strip_spc_r"

IyEvYmluL2Jhc2gKIyBmaWxlIHJlY3Vyc2l2ZSByZW1vdmFsIG9mIHdoaXRlc3BhY2VzIChidXQg
bm90IGZvcm0tZmVlZCkgYXQgdGhlIGVuZCBvZiBhIGxpbmUKZm9yIGYgaW4gYGZpbmQgLiAtbmFt
ZSAqWy5dW2NoXWAKZG8KICBlY2hvICRmCiAgbXYgJGYgJGYudG1wCiAgc2VkIC1lICJzL1tcdCBd
KiQvL2ciICRmLnRtcCA+JGYKICBybSAkZi50bXAKZG9uZQo=

--========GMXBoundary173451093954271--

