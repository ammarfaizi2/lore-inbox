Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTEaRty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 13:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTEaRty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 13:49:54 -0400
Received: from tag.witbe.net ([81.88.96.48]:10765 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261773AbTEaRtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 13:49:53 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.70] - APIC error on CPU0: 00(40)
Date: Sat, 31 May 2003 20:03:13 +0200
Message-ID: <00ae01c3279e$e7bb3e70$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1054388239.27311.3.camel@dhcp22.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On Sad, 2003-05-31 at 11:52, mikpe@csd.uu.se wrote:
> > Received illegal vector errors. Your boot log reveals that you're 
> > using ACPI and IO-APIC on a SiS chipset. Disable those and 
> try again 
> > -- I wouldn't bet on ACPI+IO-APIC working on SiS.
> 
> 2.5.x has the needed code to handle SiS APIC. Does Linus 
> 2.5.70 also have the fixes to not re-route the SMI pins ?

Where should this code be located ?

I'm ready to check my source tree, and compare with 2.5.69,
and try to make a patch ...

Paul

