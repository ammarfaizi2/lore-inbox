Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSLHH6u>; Sun, 8 Dec 2002 02:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSLHH6t>; Sun, 8 Dec 2002 02:58:49 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:56896 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S265242AbSLHH6t> convert rfc822-to-8bit; Sun, 8 Dec 2002 02:58:49 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'rtilley'" <rtilley@vt.edu>
Cc: "Linux Kernel Development List" <linux-kernel@vger.kernel.org>
Subject: RE: lilo append mem problem in 2.4.20
Date: Sun, 8 Dec 2002 02:06:34 -0600
Message-ID: <000c01c29e90$bae7d530$5b1c1c43@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3DFDE59F@zathras>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Compaq proliant 5000 4 way Pentium Pro

You mean Quad processors?  Wow!

> I used RH's 686-smp kernel config file to build the
> 2.4.20-ac1 kernel. I turned High Mem support off as
> I don't think 1 GB is high mem... is it?

Actually, anything over 896 or so MB is considered High Mem.  Don't ask me
why.  I didn't write the code.  If I did, I would have used a nice round
number.

IN OTHER WORDS, TURN HIGH MEM SUPPORT BACK ON!

Now, this part is just my guess, but try compiling the kernel for 586-smp
instead of a 686-smp.  IMHO, the documentation isn't really clear about
exactly which processor crosses the threshold, and Intel's naming convention
doesn't help either.

But I could be wrong.

Joseph Wagner

