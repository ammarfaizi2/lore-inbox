Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbTATVCA>; Mon, 20 Jan 2003 16:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTATVCA>; Mon, 20 Jan 2003 16:02:00 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:43725 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S266708AbTATVB7>; Mon, 20 Jan 2003 16:01:59 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Cliff White'" <cliffw@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: tool for testing how fast your kernel can rename files :-) 
Date: Mon, 20 Jan 2003 22:11:04 +0100
Message-ID: <000f01c2c0c8$716c4b70$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200301202036.h0KKaJ011167@mail.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> have a tool
> which creates a number of files in a directory and then starts to randomly
> rename them. During this, it should output how much it has done and how
> many renames per second it did.
> 5 minutes back I programmed such a program, you can download it from:
> http://www.vanheusden.com/Linux/rename_test-1.0.tgz
CW> Here's a suggestion:
CW> Take one Very Old Kernel (say, 2.4.2)
CW> and one Very New Kernel (2.5.59 ??)
CW> Run your test on both, and see what differences you see.
CW> If you see a change greater than 10%, that's a sign your test is
CW> useful...or not.

Ok, I do not have a system with a 2.5 kernel, but here are some results
anyway:

after 210.000 renames:
2.2.20 ext2 1535/s
2.4.20 ext2 3087/s !!
       ext3 1263/s !?


