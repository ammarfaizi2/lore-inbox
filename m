Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312458AbSDPLbe>; Tue, 16 Apr 2002 07:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDPLbd>; Tue, 16 Apr 2002 07:31:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20243 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312458AbSDPLbd>; Tue, 16 Apr 2002 07:31:33 -0400
Subject: Re: Kernel 2.4.x and gcc version
To: gmitsos@telecom.ntua.gr (Yannis Mitsos)
Date: Tue, 16 Apr 2002 12:49:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBC0A2E.3010402@telecom.ntua.gr> from "Yannis Mitsos" at Apr 16, 2002 02:25:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xRSi-0008Ga-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering if with the 2.8.1 version we will be able to obtain a 
> reliable 2.4.x kernel. According to the /Documentation/Changes file the 
> gcc 2.95.3 is required...

gcc 2.95.3 is the one that is minimal for the x86 processor core. How it
behaves with other platforms is going to vary. Many of the problems with 
the older compiler where with register allocation, which is a very big x86
problem but much less of an issue on other compilers

> Between the gcc version 2.8.1 and the 2.95.3 some extra flags and 
> options have been added, but are all these requisite for ALL the 
> processors ???

On the whole probably not.

Alan
