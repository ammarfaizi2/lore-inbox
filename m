Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311519AbSDDUPj>; Thu, 4 Apr 2002 15:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311483AbSDDUPa>; Thu, 4 Apr 2002 15:15:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51983 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311463AbSDDUPX>; Thu, 4 Apr 2002 15:15:23 -0500
Subject: Re: vcd, .dat files and isofs problem
To: davidchow@shaolinmicro.com (David Chow)
Date: Thu, 4 Apr 2002 21:32:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <3CACB1DD.2040508@shaolinmicro.com> from "David Chow" at Apr 05, 2002 04:04:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tDuI-0006jc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have problems reading the .dat files from VCD, here is the kernel 
> logs. I think it is an fs issue, since I am not the only one having the 
> same problem. In user space, read returns I/O error but I think it is an 
> fs issue or a cd-rom

VCD .dat files are not normal "files". They are encoded in a different mode
to get more bytes/sector at the cost of lower error resistance (mpeg is
error resistant in itself...)

Alan
