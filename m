Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTEVPpC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTEVPpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:45:02 -0400
Received: from mpls-qmqp-04.inet.qwest.net ([63.231.195.115]:13574 "HELO
	mpls-qmqp-04.inet.qwest.net") by vger.kernel.org with SMTP
	id S262008AbTEVPpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:45:01 -0400
Date: Thu, 22 May 2003 10:55:04 -0700
Message-ID: <000d01c3208b$46d1bf80$85b10243@oemcomputer>
From: "Paul Albrecht" <palbrecht@uswest.net>
To: linux-kernel@vger.kernel.org
Subject: strace -f pthread-app
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I strace a pthreaded program with the follow fork option the threads
get serialized, e.g., if I start threads A and B in my program, thread A
gets interrupted and thread B runs uninterrupted to completion, then A
starts up again and runs to completion.  Has any one else noticed this
behavior? Is there a way to strace -f a multithreaded program with
concurrency?



