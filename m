Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUI2Py5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUI2Py5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbUI2Py4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:54:56 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:7694 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S268670AbUI2Pyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:54:55 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Rakesh Jagota'" <j.rakesh@gdatech.co.in>,
       "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
       <kernelnewbies@nl.linux.org>
Subject: RE: opening a file inside the kernel module
Date: Wed, 29 Sep 2004 11:52:42 -0400
Organization: Connect Tech Inc.
Message-ID: <001b01c4a63c$5b5bd4d0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <001c01c4a5e9$114bf490$8200a8c0@RakeshJagota>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> I want to implement socket from the module. I won't be having any user
> process running to handle the descriptors coming from socket. 
> Could you pl
> tell me how to handle the socket descriptor from the kernel module.

Check out fs/smbfs/sock.c.

..Stu

