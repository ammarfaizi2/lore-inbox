Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTGFTIc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 15:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTGFTIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 15:08:32 -0400
Received: from mpls-qmqp-04.inet.qwest.net ([63.231.195.115]:28168 "HELO
	mpls-qmqp-04.inet.qwest.net") by vger.kernel.org with SMTP
	id S263187AbTGFTIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 15:08:31 -0400
Date: Sun, 6 Jul 2003 14:19:47 -0700
Message-ID: <001701c34404$54e72be0$6801a8c0@oemcomputer>
From: "Paul Albrecht" <palbrecht@qwest.net>
To: linux-kernel@vger.kernel.org
Subject: question about linux tcp request queue handling
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux (2.4.18) places incoming connection requests into the syn_recd state
when the server's backlog queue is full.  I thought they were supposed to be
discarded if the server's backlog is full, forcing the client to
subsequently retransmit the request after it times out.  Why does linux put
the server side into the syn_recd state when its backlog is full?

