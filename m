Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292389AbSBBV0J>; Sat, 2 Feb 2002 16:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292390AbSBBV0B>; Sat, 2 Feb 2002 16:26:01 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:32644 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S292389AbSBBVZx>; Sat, 2 Feb 2002 16:25:53 -0500
From: "Daniel J Blueman" <daniel.blueman@btinternet.com>
To: "'Benny Sjostrand'" <gorm@cucumelo.org>, <linux-kernel@vger.kernel.org>
Subject: RE: 512 Mb DIMM not detected by the BIOS!
Date: Sat, 2 Feb 2002 21:25:44 -0000
Message-ID: <000001c1ac30$2ed408a0$0100a8c0@stratus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <3C5C7C66.1050007@cucumelo.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benny,

This is a chipset problem. Chipsets support up to x CAS (column) lines
and y RAS (row) lines, and depending on your DIMM memory module layout
and configuration, you 512MB DIMM will be detected as a different sized
module.

Eg. The venerable Intel 440BX (PII) chipset supports a max of 256MB per
slot. Ah well.

Since it's a chipset (ie hardware) issue, it's not possible to work
around this problem - you need a newer chipset. Sorry.

Dan

____________________
Daniel J Blueman 

> I'm new to this mailinglist so please tellme if you think i'm "out of 
> topoic".
> 
> I've have trouble with the following issue:
> On two x86 machines, one AMD k62 and a Pentium the Bios dont wont to 
> detect properly a 512 MB PC133 DIMM, the K62 based it dont 
> detect it at 
> all, and on the PII it detect it as a 128MB DIMM.
> I suspect that's the BIOS that "sucks", not the HW, i supose 
> that the HW 
> is capable to deal with 512MB DIMM's, so my question to you 
> "kernel-gurus", is there any posibility to configure the 
> Linux kernel to 
> bypass the BIOS and actually use my 512MB ?
> 
> Thanks!
> 
> /Benny

