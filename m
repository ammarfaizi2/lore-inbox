Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289108AbSAJBEj>; Wed, 9 Jan 2002 20:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289107AbSAJBE3>; Wed, 9 Jan 2002 20:04:29 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:3286 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S289106AbSAJBEV>; Wed, 9 Jan 2002 20:04:21 -0500
From: "Daniel J Blueman" <daniel.blueman@btinternet.com>
To: "'Martin Josefsson'" <gandalf@wlug.westbo.se>
Cc: "'Ville Herva'" <vherva@niksula.hut.fi>,
        "'Andrew Morton'" <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        "'Jani Forssell'" <jani.forssell@viasys.com>
Subject: RE: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Date: Thu, 10 Jan 2002 01:04:17 -0000
Message-ID: <000001c19972$ba959050$0100a8c0@icarus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <Pine.LNX.4.21.0201100139080.14829-100000@tux.rsn.bth.se>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 10 Jan 2002, Daniel J Blueman wrote:
> 
> > There are known issues with the VIA 82C686A/B chipset 
> south-bridge and 
> > IDE in particular. Make sure you have the latest BIOS and 
> latest VIA 
> > 4in1 drivers to workaround the IDE corruption and other 
> known issues 
> > (sound problems with certain soundcards).
> 
> Yes I'm aware of these problems, I thought that the VIA 4in1 
> driver where wintendo drivers. And I also thought that there 
> are workarounds for these bugs in the kernel. 

Yep, the VIA 4in1 drivers are purely for windows.

In linux, if the chipset-fixup code is being trigged on boot (and
appears in your dmesg?), then it looks like the problem maybe
elsewhere...

On the other hand, perhaps that fixup code isn't complete (or relies on
certain chipset features being on/off by default, vendor specific
defaults?)

Dan
___________________
Daniel J Blueman

