Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTFZAs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTFZAsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:48:21 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([24.192.190.108]:260
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S265276AbTFZArB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:47:01 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Anton Blanchard'" <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Speeding up Linux kernel compiles using -pipe?
Date: Wed, 25 Jun 2003 21:01:30 -0400
Message-ID: <000001c33b7e$7b3959a0$030aa8c0@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <20030625052940.GA18786@krispykreme>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind, We are using pipe, I just didn't see due to the new Makefile
output (V=1) shows me we are using pipe, at least for ia32.

Shawn S.


-----Original Message-----
From: Anton Blanchard [mailto:anton@samba.org] 
Sent: Wednesday, June 25, 2003 1:30 AM
To: Shawn Starr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speeding up Linux kernel compiles using -pipe?



> Why aren't we using -pipe? It can significantly speed up compiles by 
> not writing temp files (intermediate files).

I thought we were. Do you have results to show it speeds up kernel compiles?
I found the opposite when using ext2:

http://www.ussg.iu.edu/hypermail/linux/kernel/0212.1/0040.html

Anton

