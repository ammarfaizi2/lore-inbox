Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287781AbSAAKIF>; Tue, 1 Jan 2002 05:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287780AbSAAKHp>; Tue, 1 Jan 2002 05:07:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61970 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287779AbSAAKHl>; Tue, 1 Jan 2002 05:07:41 -0500
Subject: Re: 2.4 / pcmcia-cs / machine check exception
To: matt@mattd.org (Matthew Dickinson)
Date: Tue, 1 Jan 2002 10:18:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112312304400.12629-100000@tornado.pdcompsys.com> from "Matthew Dickinson" at Dec 31, 2001 11:12:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LM06-0008BG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #/sbin/insmod i82365.o 
> CPU 0: Machine Check Exception 0000000000000007 
> Bank 3: b400000000000833 at 3400000000000833 
> Kernel Panic: Unable to continue 

A machine check exception is raised when there is a hardware level problem
detected (non fatal). From your description it sounds like whatever the 
detected problem was it was non fatal if ignored. If so then booting with
nomce option will disable machine checks.

Alan
