Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTBYE6h>; Mon, 24 Feb 2003 23:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBYE6h>; Mon, 24 Feb 2003 23:58:37 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8086 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S267346AbTBYE6g>; Mon, 24 Feb 2003 23:58:36 -0500
Message-ID: <006d01c2dc8c$16fb1100$c1a5190a@png.flab.fujitsu.co.jp>
From: "Takeshi Kodama" <kodama@flab.fujitsu.co.jp>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Does it have differences about information between kernel and process?
Date: Tue, 25 Feb 2003 14:09:35 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all.

I'm running zebra-0.92a on linux kernel-2.4.18.
I have a question about kernel-routing process interface.

When I configure, I can select NETLINK or IOCTL 
as kernel-routing process interface.
I think IOCTL carries information in only process->kernel direction,
not in kernel->process direction.

I have a question.

I think when I can select IOCTL as kernel-process interface,
it have differences about information between kernel and routing process.
For example, when I change interface status by "ifconfig" command,
The information in kernel is updated. But in routing process not updated.
(because IOCTL is process->kernel direction interface)

Is it no matter about such a specification? 

Is IOCTL already obsolete ?
The time when kernel didn't have NETLINK method,
Would something bad happen?

Regards.
-----
Takeshi Kodama
 

