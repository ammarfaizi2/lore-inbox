Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbRGTUfl>; Fri, 20 Jul 2001 16:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbRGTUfb>; Fri, 20 Jul 2001 16:35:31 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:7335 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S267327AbRGTUfQ>;
	Fri, 20 Jul 2001 16:35:16 -0400
Message-Id: <200107202034.f6KKYHb14563@www.2ka.mipt.ru>
Date: Sat, 21 Jul 2001 00:59:29 +0400
From: John Polyakov <johnpol@2ka.mipt.ru>
To: "David CM Weber" <dweber@backbonesecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple LKM & copy_from_user question (followup)
In-Reply-To: <94FD5825A793194CBF039E6673E9AFE00B64A0@bbserver1.backbonesecurity.com>
In-Reply-To: <94FD5825A793194CBF039E6673E9AFE00B64A0@bbserver1.backbonesecurity.com>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.6-ac2; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__21_Jul_2001_00:59:29_+0400_08202050"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.

--Multipart_Sat__21_Jul_2001_00:59:29_+0400_08202050
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Fri, 20 Jul 2001 16:26:43 -0400
"David CM Weber" <dweber@backbonesecurity.com> wrote:

DCW> Attached is the file I"m having problems with.  I'm compiling it w/ 

DCW> gcc -O3 -c main.c

DCW> Thanks in advance,

There is a Makefile for you in attachment.

Here is lsmod output:
It's work :)

[root@Sombre lkm]# lsmod
Module                  Size  Used by
main                     836   0  (unused)
NVdriver              660144  15  (autoclean)
[root@Sombre lkm]#


DCW> Dave Weber
DCW> Backbone Security, Inc.
DCW> 570-422-7900

---
WBR. //s0mbre

--Multipart_Sat__21_Jul_2001_00:59:29_+0400_08202050
Content-Type: text/plain;
 name="Makefile"
Content-Disposition: attachment;
 filename="Makefile"
Content-Transfer-Encoding: base64

Q0M9Z2NjCk1PRENGTEFHUyA6PSAtV2FsbCAtV3dyaXRlLXN0cmluZ3MgLVdyZWR1bmRhbnQtZGVj
bHMgLU8yIC1ETU9EVUxFIC1EX19LRVJORUxfXyAtRExJTlVYIC1JL3Vzci9zcmMvbGludXgvaW5j
bHVkZQpNT0RDRkxBR1MxOj0gLU8xIC1EX19LRVJORUxfXyAtRE1PRFVMRSAtV2FsbCAtRExJTlVY
IC1JL3Vzci9zcmMvbGludXgvaW5jbHVkZQptYWluLm86ICAgICAgbWFpbi5jCgkgICAgICAgICQo
Q0MpICQoTU9EQ0ZMQUdTMSkgLWMgbWFpbi5jCgo=

--Multipart_Sat__21_Jul_2001_00:59:29_+0400_08202050--
