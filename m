Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTEELcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 07:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTEELcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 07:32:25 -0400
Received: from mx0.gmx.net ([213.165.64.100]:52713 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S262144AbTEELcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 07:32:23 -0400
Date: Mon, 5 May 2003 13:44:46 +0200 (MEST)
From: S-n-e-a-k-e-r@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: questions regarding arch/i386/boot/setup.S
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0006823522@gmx.net
X-Authenticated-IP: [193.171.252.134]
Message-ID: <23912.1052135086@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I write this to the kernel mailing list, because my question couldn't be
answered on irc (eg. irc.kernelnewbie.org):
____________________________________________________________________________
arch/i386/boot/setup.S:

164 trampoline:     call    start_of_setup
165                 .space  1024
166 # End of setup header
#####################################################
167 
168 start_of_setup:
169 # Bootlin depends on this being done early
170         movw    $0x01500, %ax
____________________________________________________________________________
my questions are:

-)    Why is there a call on line 164 and not a jmp?
-)    Why does line 165 reserve 1024 bytes? what is it for?
-)    On line 170: Why $0x01500 and not $0x1500?

I would appreciate if someone could answer this mail, or if someone can
provide ressources where I can find detailed description of the kernel code
(didn't find anything, just overall information)

regards, 

andy

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!

