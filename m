Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTJSTAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTJSTAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:00:22 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:56784 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262050AbTJSTAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:00:20 -0400
Message-ID: <01f601c39671$553cbaa0$fb457dc0@tgasterix>
Reply-To: "Thomas Giese" <Thomas.Giese@gmx.de>
From: "Thomas Giese" <Thomas.Giese@gmx.de>
To: "Paul Blazejowski" <paulb@blazebox.homeip.net>
Cc: <linux-kernel@vger.kernel.org>
References: <1066588403.1232.57.camel@blaze.homeip.net>
Subject: Re: Linux-2.6.0-test8, e1000 timeouts.
Date: Sun, 19 Oct 2003 20:46:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Seen: false
X-ID: SgX63iZLQeTFN3ev3tSQhpXYO96Tg70Y-BdjncpOX9f9znFvasrNUF@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i got this in /var/log/messages with 3c59x on 2.6.0-test8, and lan is very
slow:

Oct 19 18:55:19 linux kernel: eth0: Transmit error, Tx status register 82.
Oct 19 18:55:19 linux kernel: Probably a duplex mismatch.  See
Documentation/networking/vortex.txt
Oct 19 18:55:19 linux kernel:    Flags; bus-master 1, dirty 2761(9) current
2761(9)
Oct 19 18:55:19 linux kernel:   Transmit list 00000000 vs. cfcf57a0.
Oct 19 18:55:19 linux kernel:   0: @cfcf5200  length 80000043 status
00010043
Oct 19 18:55:19 linux kernel:   1: @cfcf52a0  length 80000043 status
00010043
Oct 19 18:55:19 linux kernel:   2: @cfcf5340  length 80000043 status
00010043
Oct 19 18:55:19 linux kernel:   3: @cfcf53e0  length 80000043 status
00010043
Oct 19 18:55:19 linux kernel:   4: @cfcf5480  length 80000043 status
00010043



-----Ursprüngliche Nachricht----- 
Von: "Paul Blazejowski" <paulb@blazebox.homeip.net>
An: "LKML" <linux-kernel@vger.kernel.org>
Gesendet: Sonntag, 19. Oktober 2003 20:33
Betreff: Linux-2.6.0-test8, e1000 timeouts.


