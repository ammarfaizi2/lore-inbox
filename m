Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288597AbSANBqV>; Sun, 13 Jan 2002 20:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288612AbSANBqL>; Sun, 13 Jan 2002 20:46:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288597AbSANBpx>; Sun, 13 Jan 2002 20:45:53 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: davidsen@tmr.com (Bill Davidsen)
Date: Mon, 14 Jan 2002 01:54:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.96.1020113202508.17441L-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Jan 13, 2002 08:28:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PwKY-0000FG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feel free to quantify the savings over the current setup with max power
> saving enabled in the kernel. I just don't see how "wonderful" it would
> be, given that an idle system currently uses very little battery if you
> setup the options to save power.

IBM have a tickless kernel patch set for the S/390. Here its not battery at
stake but VM overhead sending timer interrupts to hundreds of otherwise idle
virtual machines
