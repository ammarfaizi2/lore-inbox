Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267802AbTBRNEa>; Tue, 18 Feb 2003 08:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267805AbTBRNEa>; Tue, 18 Feb 2003 08:04:30 -0500
Received: from mail.uptime.at ([62.116.87.11]:42919 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S267802AbTBRNE3>;
	Tue, 18 Feb 2003 08:04:29 -0500
Received-Date: Tue, 18 Feb 2003 13:56:52 +0100
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <axp-kernel-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Module problems (WAS: RE: 2.5.62 on Alpha SUCCESS (2.6 release soon!?))
Date: Tue, 18 Feb 2003 14:12:58 +0100
Organization: UPtime system solutions
Message-ID: <001401c2d74f$785bb720$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <000f01c2d73d$6314ce40$020b10ac@pitzeier.priv.at>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
X-MailScanner: clean
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.6, required 5.3,
	AWL, IN_REP_TO, NOSPAM_INC, PLING_QUERY, QUOTED_EMAIL_TEXT,
	SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Pitzeier wrote:
> I just wanted to tell everybody that 2.5.62 works great for 
> me on Alpha... Thanks a lot to the alpha kernel developers!!! 
> You did a great job...
[ ... ]

OK... Make modules_install still has problems:

[root@track linux]# make modules_install
make -rR -f scripts/Makefile.modinst
  mkdir -p /lib/modules/2.5.62/kernel/net/8021q; cp net/8021q/8021q.ko
/lib/modules/2.5.62/kernel/net/8021q
  mkdir -p /lib/modules/2.5.62/kernel/fs/autofs4; cp fs/autofs4/autofs4.ko
/lib/modules/2.5.62/kernel/fs/autofs4
  mkdir -p /lib/modules/2.5.62/kernel/drivers/net; cp drivers/net/bonding.ko
/lib/modules/2.5.62/kernel/drivers/net
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.62; fi
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: Unhandled relocation of type 10 for .text
depmod: depmod obj_relocate failed

make: *** [_modinst_post] Error 1

Best regards,
 Oliver


