Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTKSMCH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 07:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTKSMCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 07:02:07 -0500
Received: from muncii-fe0.b.astralnet.ro ([194.102.255.69]:42657 "EHLO
	linux.kappa.ro") by vger.kernel.org with ESMTP id S264022AbTKSMCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 07:02:04 -0500
Date: Wed, 19 Nov 2003 14:02:02 +0200
From: Teodor Iacob <Teodor.Iacob@astral.ro>
To: linux-kernel@vger.kernel.org
Subject: Intel E1000 and IDE problems
Message-ID: <20031119120202.GD15974@speedy.b.astralnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently put up 2 intel network adapters:
00:09.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)

( I replaced some Intel PRO1000 Desktop which I had before ) and now
I get serious problems with the hda disk:

Nov 19 12:42:28 firelog2 kernel: hda: status timeout: status=0x82 { Busy }
Nov 19 12:42:28 firelog2 kernel:
Nov 19 12:42:28 firelog2 kernel: hda: DMA disabled
Nov 19 12:42:28 firelog2 kernel: hda: drive not ready for command
Nov 19 12:42:33 firelog2 kernel: ide0: reset: success
Nov 19 12:43:53 firelog2 kernel: hda: status timeout: status=0x80 { Busy }
Nov 19 12:43:53 firelog2 kernel:
Nov 19 12:43:53 firelog2 kernel: hda: drive not ready for command
Nov 19 12:43:54 firelog2 kernel: ide0: reset: success
Nov 19 12:46:19 firelog2 kernel: hda: status timeout: status=0x80 { Busy }
Nov 19 12:46:19 firelog2 kernel:
Nov 19 12:46:19 firelog2 kernel: hda: drive not ready for command
Nov 19 12:46:19 firelog2 kernel: ide0: reset: success

>From time to time I cannot even boot the system ( even the e1000 module
is not loaded )

The kernel version is 2.4.22 and the intel driver version is : 5.2.20

( I was using the same intel driver and the same kernel version before with
Intel PRO1000 Desktop adapter )

Can anybody help me track down this? to see if it's something hardware related,
only software... is it DMA related?

Teo
