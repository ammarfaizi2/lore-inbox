Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTEDWeD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 18:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTEDWeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 18:34:03 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:21764 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S261819AbTEDWeC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 18:34:02 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Cannot install 2.5.68 on Red Hat 8
Date: Sun, 4 May 2003 23:46:40 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305042346.40322.adrian@mcmen.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to install 2.5.68 on an SMP box running a fairly bog 
standard Red Hat 8 distro.

The compile works, but the installation fails:

Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.5.68 arch/i386/boot/bzImage System.map ""
No module aic7xxx found for kernel 2.5.68
make[1]: *** [install] Error 1
make: *** [install] Error 2


I understand, from googling old lkml messages, that this is likely to be due 
to Red Hat's mkinitrd.

Is that correct?

Is there a fix?

Adrian
adrian@mcmen.demon.co.uk
