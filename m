Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbQKOU2z>; Wed, 15 Nov 2000 15:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQKOU2f>; Wed, 15 Nov 2000 15:28:35 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:57362 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129584AbQKOU2a>; Wed, 15 Nov 2000 15:28:30 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200011151958.LAA09896@cx518206-b.irvn1.occa.home.com>
Subject: [BUG?] AMD 5x86 and 2.4 (was Re: [BUG?] AMD K5 and 2.4)
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Nov 2000 11:58:27 -0800 (PST)
Cc: hahn@coffee.psychology.mcmaster.ca
Reply-To: barryn@pobox.com
In-Reply-To: <200011150435.UAA05562@cx518206-b.irvn1.occa.home.com> from "Barry K. Nathan" at Nov 14, 2000 08:35:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like I was mistaken in my original message. I have an AMD 5x86, not
a K5.

Nevertheless, menuconfig lists the 586 option as "586/K5/5x86/6x86/6x86MX".
But, it fails to boot on my 5x86 and I have to compile for a 486 (for 2.4).
As I mentioned in my previous message, the 586/... option boots with 2.2.

I just noticed that, under both 2.2 and 2.4, uname -a identifies the
machine as an i486.

Should the 486 option be changed to "486/5x86" and the 586/... option
changed to "586/K5/6x86/6x86MX"? Or is there a bug here that needs fixing?
(IIRC, Cyrix and IBM made 5x86's as well - are those more like fast 486's
or slow Pentiums? I don't remember. If they're like Pentiums, perhaps
"486/AMD 5x86" and "586/non-AMD 5x86/6x86/6x86MX"...?)

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
