Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRDCOe1>; Tue, 3 Apr 2001 10:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbRDCOeS>; Tue, 3 Apr 2001 10:34:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17670 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131979AbRDCOeL>; Tue, 3 Apr 2001 10:34:11 -0400
Subject: Re: uninteruptable sleep
To: ocdi@ocdi.org (Trevor Nichols)
Date: Tue, 3 Apr 2001 15:35:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.33.0104032217220.60098-100000@ocdi.sb101.org> from "Trevor Nichols" at Apr 03, 2001 10:38:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kRuT-0008Bc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One last thing, if this turns out to be a non-kernel problem, the
> processes that *do* get stuck, are unkillable - even by root with SIGKILL.
> Is there any way for it to be able to? :)  So far I have to reboot each
> time it happens.

Its a kernel bug if it gets stuck like this. You need to provide more info
though - what file system, what devices, how much memory. Also ps can give you
the wait address of a process stuck in 'D' state which is valuable for debug
