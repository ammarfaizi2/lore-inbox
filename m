Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbSJQGym>; Thu, 17 Oct 2002 02:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJQGym>; Thu, 17 Oct 2002 02:54:42 -0400
Received: from 217-13-4-9.dd.nextgentel.com ([217.13.4.9]:21417 "HELO
	mail.broadpark.no") by vger.kernel.org with SMTP id <S261837AbSJQGyl>;
	Thu, 17 Oct 2002 02:54:41 -0400
Message-ID: <3DAE605F.3B744FFC@broadpark.no>
Date: Thu, 17 Oct 2002 09:01:51 +0200
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.7-dj2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.43 smp bootup crash
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.43 smp (with Andrew Morton's md-fix)
didn't survive bootup.

It produced a backtrace so long that most of it
scrolled off the screen, before stating that
it didn't sync in an interrupt handler.

The machine was dead, even sysrq+B couldn't
reboot it. 

The kernel has preempt, and autodetection of
raid-1 and raid-0.

Helge Hafting
