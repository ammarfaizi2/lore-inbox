Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTDELok (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 06:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTDELok (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 06:44:40 -0500
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:42747
	"EHLO flat") by vger.kernel.org with ESMTP id S262120AbTDELoj (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 06:44:39 -0500
Date: Sat, 5 Apr 2003 12:56:47 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: 2.5.66-mm3 PCMCIA network card loses configuration after suspend
Message-ID: <20030405115647.GA1283@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

In 2.5.66-mm3, using a PCMCIA network card (3c574_cs), a APM suspend/resume
causes the network interface configuration to be lost. In previous kernels this
the interface configuration is preserved.

I also get the following messages written to the console, presumably these
messages are KERN_EMERG temporarily for debugging.

Message from syslogd@flat at Sat Apr  5 12:31:46 2003 ...
flat kernel: Suspending devices
Message from syslogd@flat at Sat Apr  5 12:31:46 2003 ...
flat kernel: Devices Resumed

Debian sid, pcmcia-cs 3.2.2

Charlie

