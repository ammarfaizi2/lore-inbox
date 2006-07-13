Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWGMGHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWGMGHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWGMGHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:07:42 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:61074 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S932359AbWGMGHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:07:42 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Very long startup time for a new thread
Date: Thu, 13 Jul 2006 08:07:40 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B55B0@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This is on a 200 MIPS embedded architecture).

On a heavily loaded system (loadavg ~4) I create a new pthread. In this
situation it takes ~4 seconds (!) before the thread is first scheduled in
(yes, I have debug outputs in the scheduler to check that). In a 2.4 based
system I don't see the same thing. I don't have any RT or FIFO tasks. Any
ideas why it takes so long time and what I can do about it?

Appreciate any help
/Mikael

