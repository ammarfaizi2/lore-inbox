Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbRBBKjk>; Fri, 2 Feb 2001 05:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbRBBKjb>; Fri, 2 Feb 2001 05:39:31 -0500
Received: from mail.delrom.ro ([193.231.234.28]:38412 "HELO mail.delrom.ro")
	by vger.kernel.org with SMTP id <S129121AbRBBKj0>;
	Fri, 2 Feb 2001 05:39:26 -0500
Date: Fri, 2 Feb 2001 12:38:49 +0200
From: Silviu Marin-Caea <silviu@delrom.ro>
To: linux-kernel@vger.kernel.org
Subject: Installation on RAID volume (Mylex controller)
Message-Id: <20010202123849.5631f308.silviu@delrom.ro>
X-Mailer: Sylpheed version 0.4.60 (GTK+ 1.2.8; Linux 2.4.1; i686)
Organization: Delta Romania
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.5.0.8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to install on a RAID volume controlled by a Mylex 170.

Built an image of a 2.4.1 with DAC960/DAC1100 "compiled in" and copied
it over vmlinuz on a Red Hat 7 boot diskette (boot.img).

I entered this at the boot prompt

boot: linux root=/dev/rd/c0d0

DAC960 appears to detect correctly the volume
[...]
Kernel panic: I have no root and I want to scream
[...]
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Found
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Online

It seems the kernel wants a root before it becomes Online.

What now?

-- 
Systems and Network Administrator - Delta Romania
Phone +4093-267961
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
