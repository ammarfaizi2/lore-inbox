Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285192AbRLMVaz>; Thu, 13 Dec 2001 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285193AbRLMVap>; Thu, 13 Dec 2001 16:30:45 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([210.147.6.230]:40911 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S285192AbRLMVa3>; Thu, 13 Dec 2001 16:30:29 -0500
X-Biglobe-Sender: <k-suganuma@mvj.biglobe.ne.jp>
Date: Thu, 13 Dec 2001 13:29:42 -0800
From: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] HotPlug CPU patch against 2.5.0
Cc: k-suganuma@mvj.biglobe.ne.jp, large-discuss@lists.sourceforge.net,
        "Heiko Carstens" <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        "Anton Blanchard" <antonb@au1.ibm.com>,
        "Greg Kroah-Hartman" <ghartman@us.ibm.com>, rusty@rustcorp.com.au
Message-Id: <20011213132557.5B3E.K-SUGANUMA@mvj.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Hotplug CPU patch for 2.5.0 is uploaded.

  http://sourceforge.net/projects/lhcs/

This patch works on s390, s390x, x86 and ia64 architectures.
It can also be applied against 2.4.16 with a little modification.

Down CPU
echo 0 > /proc/sys/kernel/cpu/<id>/online

Up CPU
echo 1 > /proc/sys/kernel/cpu/<id>/online

For ia64, number of CPUs to be initialized can be
specified with "initcpus=<num>" option for elilo.
With using the option, you can test real hot-add CPU
function without a HW ready for hotplug.

Thanks,
Kimi

-- 
Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>

