Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291043AbSCHXXB>; Fri, 8 Mar 2002 18:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290809AbSCHXWw>; Fri, 8 Mar 2002 18:22:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56082 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289348AbSCHXWk>; Fri, 8 Mar 2002 18:22:40 -0500
Subject: Re: Promise Supertrack SX6000 problems with kernel 2.4.19-pre2-ac2
To: raj76@arches.uga.edu (A N Saravanaraj)
Date: Fri, 8 Mar 2002 23:38:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004701c1c6f6$37d90af0$ad05c080@chem.uga.edu> from "A N Saravanaraj" at Mar 08, 2002 06:08:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jTw6-0007xn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> promise SX6000 card and it was working fine. Then I decided to upgrade the
> kernel to the new version 2.4.18. I down loaded the sources and compiled the
> I2O support as modules. Did the installation of the kernel and the machine
> does not find the I2O card as before and hangs at finding new hardware. Can

Well if its a module it won't find it until the module is loaded. There
are several interesting problems with older SX6000 firmware and i2o when
you load and then reload the i2o module more than once. Kudzu trips this
up.
