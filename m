Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315799AbSEOODe>; Wed, 15 May 2002 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315842AbSEOODd>; Wed, 15 May 2002 10:03:33 -0400
Received: from zeke.inet.com ([199.171.211.198]:64702 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S315799AbSEOODc>;
	Wed, 15 May 2002 10:03:32 -0400
From: "Jordan Breeding" <jordan.breeding@inet.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Jordan Breeding" <jordan.breeding@inet.com>,
        "Jordan Breeding" <jordan.breeding@attbi.com>
Subject: Problem with nmi watchdog
Date: Wed, 15 May 2002 09:01:58 -0500
Message-ID: <HAEOIKGLLLDPLCHFOMMOAECNCAAA.jordan.breeding@inet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I have a Tyan Thunder K7 (S2462UNG) which does not like using the nmi
watchdog automatically.  If I boot up nmi_watchdog=1 then the machine show
no interrupt in the nmi columns of /proc/interrupts.  While checking the
boot log I see the message about CPU#0 being stuck.  This is made more
interesting by the fact that if I boot using nmi_watchdog=2 then everything
works fine.  Why will the automatic detection using nmi_watchdog=1 not work
(my current kernel is 2.5.15-dj1)?  Thanks.

Jordan Breeding

