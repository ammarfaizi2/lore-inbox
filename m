Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317830AbSGVV7s>; Mon, 22 Jul 2002 17:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317842AbSGVV7s>; Mon, 22 Jul 2002 17:59:48 -0400
Received: from mail.bizrate.com ([216.52.235.12]:55301 "EHLO
	privatemail.bizrate.com") by vger.kernel.org with ESMTP
	id <S317830AbSGVV7r>; Mon, 22 Jul 2002 17:59:47 -0400
From: "Rick Parada" <rick@bizrate.com>
To: <linux-kernel@vger.kernel.org>
Cc: <riel@conectiva.com.br>
Subject: Rik Van Riel Patch - rmap-12h - Memory Issues - VM
Date: Mon, 22 Jul 2002 15:06:31 -0700
Message-ID: <NEBBKPCLBMALOLFGJEJGOEEGHEAA.rick@bizrate.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original message (07/11/2002)


I installed patch rmap-12h to a 2.4.18 vanilla kernel, and we will see how
things run in about 4 days. That's how long it takes cache to fill up (4gb
of memory) and available memory to reach almost nil. This will be a perfect
box to test out your patch. We have about 4+ million images we rsync
everyday. Well we don't rsync that many a day, but rsync loads the file list
in memory. So hopefully kswapd and rsync won't reek havoc on the cpu load
when rsync tries to suck my memory dry.


With the rmap-12h patch to 2.4.18 (07/22/2002)

Rik,

After 11 days of uptime your patch is working GREAT. Although cache is
filled up again and there is only 70 megs free of memory top is reporting. I
assume that this is just normal behavior. When rsync runs, memory from buff
is free allowing rsync the memory to run seamless. And I notice that the
kswapd time that top is reporting is far less than say the 2.4.18 kernel
vanilla or 2.4.8 vanilla (two other boxes with the same configurations). Why
is this? If you have time maybe you could explain to me in layman's terms
what your patch actually does. Your patch actually saved us from having to
buy newer and faster equipment which probably wouldn't have help.

Thanks Again
Rick Parada
Systems Administrator
BizRate.com

