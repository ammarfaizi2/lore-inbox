Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTJJHBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJJHBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:01:08 -0400
Received: from orngca-mls01.socal.rr.com ([66.75.160.16]:2523 "EHLO
	orngca-mls01.socal.rr.com") by vger.kernel.org with ESMTP
	id S262567AbTJJHBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:01:07 -0400
Message-ID: <007b01c38ea2$c7ea40d0$6401a8c0@alpha>
From: "Tom Handal" <thandal@san.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Wierd Problem with Current Task Struct
Date: Thu, 9 Oct 2003 13:20:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

     I am currently having a problem with the "current" task struct in the
2.4.18-4GB SUSE80 Kernel ... I am writing a kernel module that is calling
down through a system call... The system call is getting the PID and FS
pointer from the Current task struct, but the FS pointer is NULL and the PID
is 0 .... Is this normal? Should current->fs ever be NULL? I haven't noticed
anyone checking it in the Linux Kernel, so I think it is assumed to always
be a good value... Can anyone shed light on this?

Thanks in advance....
Tom

