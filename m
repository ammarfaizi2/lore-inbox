Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129544AbQKGMNg>; Tue, 7 Nov 2000 07:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbQKGMN0>; Tue, 7 Nov 2000 07:13:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62838 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129544AbQKGMNH>; Tue, 7 Nov 2000 07:13:07 -0500
Subject: Re: Pentium 4 and 2.4/2.5
To: andre@linux-ide.org (Andre Hedrick)
Date: Tue, 7 Nov 2000 12:13:41 +0000 (GMT)
Cc: fdavis112@juno.com (Frank Davis), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011061940200.18160-100000@master.linux-ide.org> from "Andre Hedrick" at Nov 06, 2000 07:41:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7dG-0007KT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not to worry, some of us are working with the 'I' guys to do proper P4
> detection.

Be careful with the intel patches. The ones I've seen so far tried to call the
cpu 'if86' breaking several tools that do cpu model checking off uname. They
didnt fix the 2GHz CPU limit, they use 'rep nop' in the locks which is
explicitly 'undefined behaviour' for non intel processors and they use the
TSC without checking it had one.

Hopefully they have improved since

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
