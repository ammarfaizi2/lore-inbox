Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265451AbTFZHpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 03:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbTFZHpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 03:45:16 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:21422 "EHLO
	mwinf0102.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265451AbTFZHpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 03:45:14 -0400
From: "R.C" <rafaled@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: HyperThreading not working under 2.4.21
Date: Thu, 26 Jun 2003 09:57:48 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306260957.48103.rafaled@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I recently tried to upgrade to the 2.4.21 vanilla kernel. I am using a Pentium 
IV 3,06ghz HT. Amongst other things, I enabled the following options: 
"Pentium-4 processor Family, SMP support, ACPI support". I tried it with both 
ACPI support on and off. I can join a copy of my .config if it is required.

Anyway, when booting the 2.4.21 kernel my second logical processor
is not detected at all. All works as if I had only one processor. There is no 
error message. A cat /proc/cpuinfo reports only one cpu.

This problem only occurs with 2.4.21 kernel. My HT processor was working 
perfectly with any branch of the 2.4.20 serie (I was using 2.4.20-ck6). My 
second logical processor was perfectly recognized. Thus, it does not seem to 
be a problem with bios or mb settings.

A "very" quick search through google made me conclude that this problem had 
not been reported yet so please, forgive me if you are all already aware of 
such a problem.

Best regards,

            R.C


P.S: join a copy to my e-mail adress if you may.

