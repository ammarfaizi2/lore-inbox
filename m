Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131689AbQKCUd3>; Fri, 3 Nov 2000 15:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131769AbQKCUdT>; Fri, 3 Nov 2000 15:33:19 -0500
Received: from hvmta03-ext.us.psimail.psi.net ([38.202.36.27]:14539 "EHLO
	hvmta03-stg.us.psimail.psi.net") by vger.kernel.org with ESMTP
	id <S131689AbQKCUdL>; Fri, 3 Nov 2000 15:33:11 -0500
From: "Chris Swiedler" <chris.swiedler@sevista.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: include fb.h from userland?
Date: Fri, 3 Nov 2000 15:36:45 -0500
Message-ID: <NDBBIAJKLMMHOGKNMGFNMEKECOAA.chris.swiedler@sevista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand that the headers in /usr/include/linux shouldn't be overwritten
by new kernel installs. But can someone elaborate on Linus's original
admonition
(http://kernelnotes.org/lnxlists/linux-kernel/lk_0007_04/msg00881.html)? Am
I never, ever, ever allowed to update my system headers for the rest of my
life, or is it only if I follow some particular procedure, such as
recompiling glibc?

The reason I want to upgrade my system headers is that framebuffer
development requires linux/fb.h to be included from userland (I see no way
around that). The version of fb.h in my system headers is 2.2.5, the distro
version I originally installed. I'm running 2.2.17 kernel now, which has
much newer fb.h which I need.

chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
