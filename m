Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUDZRz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUDZRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUDZRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 13:55:56 -0400
Received: from mail1.webmessenger.it ([193.70.193.50]:4259 "EHLO
	mail1c.webmessenger.it") by vger.kernel.org with ESMTP
	id S263163AbUDZRz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 13:55:29 -0400
From: "Martin Angler" <martin.angler@email.it>
To: <linux-kernel@vger.kernel.org>
Subject: Driver in user space/RS485
Date: Mon, 26 Apr 2004 19:55:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQrt6dGINBI/XQmQkWZSAZFCHNPkA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-Id: <S263163AbUDZRz3/20040426175529Z+110@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have to develop a pseudo-device driver that gets data from a RS485
interface, frames it and gives the framed data to libpcap. This whole thing
is a university project. Now I know, that writing a kernel module I can't be
using the standard C library for invocations of read() or ioctl() methods in
order to get the data from the RS485 interface. 

So my plan would be writing a driver xxx which has its file operations
xxx_read, xxx_open and xxx_release. xxx_read should call then some kind of
read method in order to get the data from the RS485. Are there any exported
symbols from the RS485 driver? Or do I have to write the whole driver in
user space in order to access the RS485 interface?

Thanks in advance,
Martin Angler

