Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTEVRpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTEVRpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:45:11 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:49373 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S262878AbTEVRpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:45:10 -0400
Message-ID: <000701c3208b$e59201c0$0305a8c0@arch.sel.sony.com>
From: "Ming Lei" <lei.ming@attbi.com>
To: <linux-kernel@vger.kernel.org>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil> <20030514205949.GA3945@kroah.com>
Subject: Linux 2.4 scheduler is RTOS-alike?
Date: Thu, 22 May 2003 10:59:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this question is regarding linux kernel 2.4.7-2.4.20.
linux 2.4 kernel does support real time sheduler. If using FIFO real time
schedule policy, would the case that higher priority thread starve the lower
priority thread happen?  Similarly, let's say an example: if I have higher
prioority thread A and lower priority thread B, thread A is running without
any wait or blocking, is there a possiblity that 2.4 scheduler may want to
switch to thread B? Why?

If I want to instrument the 2.4 kernel to print out the message for every
thread context switch, where should I put the trace point?


