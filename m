Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVDHG4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVDHG4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVDHG4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:56:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:62170 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262658AbVDHG4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:56:41 -0400
Date: Fri, 8 Apr 2005 08:56:40 +0200 (MEST)
From: "Marco Schwarz" <marco.schwarz@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Dual Opteron / Kernel Panic
X-Priority: 3 (Normal)
X-Authenticated: #12086198
Message-ID: <9634.1112943400@www2.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

today I got the following messages on one of our dual Opteron servers:

Apr  8 08:40:21 dslxs01neu kernel: CPU 1: Machine Check Exception:
0000000000000007
Apr  8 08:40:21 dslxs01neu kernel: Bank 4: f47520009c080a13 at
00000001e89ccdf0
Apr  8 08:40:21 dslxs01neu kernel: Kernel panic: Unable to continue
Apr  8 08:40:21 dslxs01neu kernel: klogd 1.4.1, ---------- state change
---------- 
Apr  8 08:40:21 dslxs01neu kernel: Inspecting
/boot/System.map-2.4.21-286-smp
Apr  8 08:40:25 dslxs01neu kernel: Loaded 22027 symbols from
/boot/System.map-2.4.21-286-smp.
Apr  8 08:40:25 dslxs01neu kernel: Symbols match kernel version 2.4.21.
Apr  8 08:40:25 dslxs01neu kernel: Loaded 588 symbols from 21 modules.

The machine is still up and running, but 'Kernel panic' seems to be
something serious ;-)

Can some tell me what these messages mean ?

Thanks a lot,
Marco Schwarz
