Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSLFTUl>; Fri, 6 Dec 2002 14:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSLFTUl>; Fri, 6 Dec 2002 14:20:41 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:62556 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S265647AbSLFTUk> convert rfc822-to-8bit; Fri, 6 Dec 2002 14:20:40 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "Linux Kernel Development List" <linux-kernel@vger.kernel.org>
Subject: INFO REQ: Please Clarify About Memory Management
Date: Fri, 6 Dec 2002 13:28:13 -0600
Message-ID: <000001c29d5d$a3bc2110$19415aa6@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a little confused about the way the Linux kernel allocates memory, and
I'm hoping someone could clarify this for me.

Does the __get_free_pages() function eventually call the kmalloc() function?
Or does the kmalloc() function eventually call the __get_free_pages()
function?  Or are these two totally separate functions for different
purposes?

Which of these functions can be called by user process for the purpose of
allocating memory for that user process?

TIA

Joseph Wagner

Flames will be directed to /dev/null

