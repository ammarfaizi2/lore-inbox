Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbRBRUYx>; Sun, 18 Feb 2001 15:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129404AbRBRUYe>; Sun, 18 Feb 2001 15:24:34 -0500
Received: from SMTP-OUT003.ONEMAIN.COM ([63.208.208.73]:27112 "HELO
	smtp01.mail.onemain.com") by vger.kernel.org with SMTP
	id <S129341AbRBRUYa>; Sun, 18 Feb 2001 15:24:30 -0500
Message-ID: <3A902F77.8BF6AB52@teleport.com>
Date: Sun, 18 Feb 2001 12:24:23 -0800
From: Scott Long <smlong@teleport.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux OS boilerplate
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been poring over the x86 boot code for a while now and I've been
considering writing a FAQ on the boot process (mostly for my own use,
but maybe others will be interested). This would include all relevant
information on setting up the x86 hardware for a boot (timers, PIC, A20,
protected mode, GDT, initial page tables, initial TSS, etc).

The motivation behind this is that I would like to use the Linux boot
system as a boilerplate booter for some experimental code. It's probably
much cleaner and more robust than any boot loader I might come up with.

Does there exist an outline (detailed or not) of the boot process from
the point of BIOS bootsector load to when the kernel proper begins
execution? If not would anyone be willing to help me understand
bootsect.S and setup.S enough so that I might write such an outline?

If no one can help me, would you consider it appropriate for me to send
email to the people listed in bootsect.S and setup.S asking for
assistance?

Thanks,
Scott
