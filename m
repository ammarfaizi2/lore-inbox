Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRBTDvZ>; Mon, 19 Feb 2001 22:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRBTDvF>; Mon, 19 Feb 2001 22:51:05 -0500
Received: from [210.77.38.126] ([210.77.38.126]:47111 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S129441AbRBTDvD>; Mon, 19 Feb 2001 22:51:03 -0500
Date: Tue, 20 Feb 2001 11:30:59 +0800
From: michaelc <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.48) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <1517849203.20010220113059@turbolinux.com.cn>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: about acpi problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
        I found that acpi driver has some bugs, I compiled the 2.4.2-pre4
  kernel with the acpi support option and SMP enabled, it caused hang at the
  boot time, but when I disabled the SMP option, it 's OK , so I look
  into the acpi driver source code, and I found the acpi idle function
  don't support the SMP, is that cause the kernel hang at boot time.
  

-- 
Best regards,
 michaelc                          mailto:michaelc@turbolinux.com.cn


