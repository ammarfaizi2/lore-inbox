Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129438AbRBWTsb>; Fri, 23 Feb 2001 14:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbRBWTsV>; Fri, 23 Feb 2001 14:48:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17421 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129300AbRBWTsI>; Fri, 23 Feb 2001 14:48:08 -0500
Subject: Re: regular lockup on 2.4.2 (w/oops)
To: brendan@kublai.com (Brendan Cully)
Date: Fri, 23 Feb 2001 19:50:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010223143458.A596@xanadu.kublai.com> from "Brendan Cully" at Feb 23, 2001 02:34:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WOF1-0006yd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if it's related to ACPI and/or IDE - I seem to get on
> occasion one ide_dmaproc: lost interrupt message during fsck - after a
> few seconds it recovers only to hang for good some 10-15 seconds
> later.

Turn off ACPI and try that kernel. If that one also causes problems then it
helps a lot as it implies its not ACPI. If it works then its ACPI and most
of us will be happy (except Andrew of course)



