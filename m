Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314652AbSEBQxY>; Thu, 2 May 2002 12:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314650AbSEBQxW>; Thu, 2 May 2002 12:53:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24077 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314652AbSEBQxV>; Thu, 2 May 2002 12:53:21 -0400
Subject: Re: i860 Chipset and Hyper-Threading Processors
To: ciesinskna26@uww.edu (Nick Ciesinski)
Date: Thu, 2 May 2002 18:12:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000701c1f1f6$aa0074d0$1cde928c@UW3RYG00Y7HQGM> from "Nick Ciesinski" at May 02, 2002 11:30:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173K81-0004NP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> patch that was delayed at that time.  The user at that time was using
> kernel 2.4.17, I am using kernel 2.4.18 and I am getting the message.
> Was the patch ever added to the new kernel?  I could not see anything

It should be addressed in 2.4.19pre.

> ENABLING IO-APIC IRQs
> BIOS bug, IO-APIC#0 ID 2 is already used!...
> ... fixing up to 4. (tell your hw vendor)
> ...changing IO-APIC physical APIC ID to 4 ... ok.

The BIOS booted up with two devices having the same device ID. Thats a bit
naughty but I don't think its technically a violation of the MP 1.4 spec
merely very dumb 8). Linux renumbered it for you
