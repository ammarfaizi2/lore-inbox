Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310461AbSCGTJC>; Thu, 7 Mar 2002 14:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310460AbSCGTIz>; Thu, 7 Mar 2002 14:08:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19986 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310461AbSCGTIV>; Thu, 7 Mar 2002 14:08:21 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Thu, 7 Mar 2002 19:22:01 +0000 (GMT)
Cc: yodaiken@fsmlabs.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <E16j2IV-0003B6-00@starship.berlin> from "Daniel Phillips" at Mar 07, 2002 07:07:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j3Sj-0003Jb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So it can return NULL? 
> 
> Returning null here won't help if the caller doesn't have a fallback, or if the fallback
> is unacceptable, such as losing a filesystem transaction.

Not having a fallback is unacceptable. Thats the real problem. You can't
go around pandering to sloppy coders who can't work a memory allocator

