Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288681AbSADQwD>; Fri, 4 Jan 2002 11:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288682AbSADQvy>; Fri, 4 Jan 2002 11:51:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33299 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288681AbSADQvq>; Fri, 4 Jan 2002 11:51:46 -0500
Subject: Re: LSB1.1: /proc/cpuinfo
To: esr@thyrsus.com
Date: Fri, 4 Jan 2002 17:02:34 +0000 (GMT)
Cc: schwab@suse.de (Andreas Schwab), andersen@codepoet.org (Erik Andersen),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20020104080358.A11215@thyrsus.com> from "Eric S. Raymond" at Jan 04, 2002 08:03:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MXjm-0004jo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the PPC etc. have 32-bit ints then I stand corrected, but I thought the 
> compiler ports on those machines used the native register size same as
> everybody else.

Nobody I am aware of uses 64bit int default types on a 64bit platform.  Its
a waste of memory, bus bandwidth and instruction bandwidth. In almost
all cases a 32bit int is quite adequate and since size_t can be 64bit when
int is 32bit life works out nicely.

Alan
