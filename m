Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133117AbRDVCRy>; Sat, 21 Apr 2001 22:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133118AbRDVCRf>; Sat, 21 Apr 2001 22:17:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8718 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133117AbRDVCRc>; Sat, 21 Apr 2001 22:17:32 -0400
Subject: Re: BUG: Global FPU corruption in 2.2
To: root@chaos.analogic.com
Date: Sun, 22 Apr 2001 03:18:56 +0100 (BST)
Cc: drepper@cygnus.com (Ulrich Drepper), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010421213945.1407A-100000@chaos.analogic.com> from "Richard B. Johnson" at Apr 21, 2001 09:46:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r9Sk-0004ot-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only if it traps on the esc op-code --and if it does, we are in a
> world or hurt for performance. There is no other way that the kernel

FPU lazy task switch exceptions are a feature of X86 hardware. Have been for
a very very long time.

