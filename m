Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131959AbQKZD0u>; Sat, 25 Nov 2000 22:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132114AbQKZD0a>; Sat, 25 Nov 2000 22:26:30 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:37636 "EHLO
        barry.mail.mindspring.net") by vger.kernel.org with ESMTP
        id <S131959AbQKZD0Z>; Sat, 25 Nov 2000 22:26:25 -0500
From: ttsig@mindspring.com
Date: Sat, 25 Nov 2000 21:55:37 -0500
To: linux-kernel@vger.kernel.org
Subject: test11-ac4, APM & Dell 5000e
Message-ID: <Springmail.105.975207337.0.66247700@www.springmail.com>
X-Originating-IP: 165.247.172.192
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Thanks for the workaround on the Dell 5000e APM problems.

However, there does seem to be a small typo in the patch.  The
comments state that the A04 BIOS dates 08/24/2000 is known defective,
but the code itself is looking for 08/04/2000.

With this small fix it actually "Works for Me" (well, minus the power
status stuff of course) but at least I get real working suspend/resume.

Later,
Tom

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
