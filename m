Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTEaL6j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTEaL6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:58:38 -0400
Received: from tag.witbe.net ([81.88.96.48]:6414 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264303AbTEaL6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:58:38 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <mikpe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.70] - APIC error on CPU0: 00(40)
Date: Sat, 31 May 2003 14:11:58 +0200
Message-ID: <008301c3276d$d5efb1c0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200305311052.h4VAqxEM001927@harpo.it.uu.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
> Received illegal vector errors. Your boot log reveals that 
> you're using ACPI and IO-APIC on a SiS chipset. Disable those 
> and try again -- I wouldn't bet on ACPI+IO-APIC working on SiS.
> 

Hmmm... So, why did it start with 2.5.70 ? 
It was fine with 2.5.69, and 2.5.69 also contains the code to
display these messages, in arch/i386/kernel/apic.c

Paul

