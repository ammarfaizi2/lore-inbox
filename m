Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289619AbSAJTYj>; Thu, 10 Jan 2002 14:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289634AbSAJTYY>; Thu, 10 Jan 2002 14:24:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289627AbSAJTX7>; Thu, 10 Jan 2002 14:23:59 -0500
Subject: Re: i810_audio driver v0.19 still freezes machine
To: dledford@redhat.com (Doug Ledford)
Date: Thu, 10 Jan 2002 19:35:28 +0000 (GMT)
Cc: pavenis@latnet.lv (Andris Pavenis), tom@infosys.tuwien.ac.at,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C3DDA8B.4090004@redhat.com> from "Doug Ledford" at Jan 10, 2002 01:16:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Okz2-0005JM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm unable to duplicate this (the current 0.19 driver doesn't hang at all on 
> me now under any of my tests).  Try to find a way to duplicate it (either by 
> playing a specific wav file using the play command, or by doing something in 
> particular to make artsd do it, or something else).  If you can find a way 
> to duplicate it, then I can see about getting a proper fix for it.

Make sure you test with both apic and non apic Doug. The previous hangs I
fixed up were specific to APIC mode because the APIC means the irq arrival
is later and more asynchronous
