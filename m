Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289978AbSAKPLk>; Fri, 11 Jan 2002 10:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289977AbSAKPLZ>; Fri, 11 Jan 2002 10:11:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44805 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289978AbSAKPLJ>; Fri, 11 Jan 2002 10:11:09 -0500
Subject: Re: [patch] O(1) scheduler, -H5
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 11 Jan 2002 15:22:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020111145811.B31366@flint.arm.linux.org.uk> from "Russell King" at Jan 11, 2002 02:58:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P3W4-0007vd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately it wasn't a simple "replace global irq with spinlocks" - some
> code also got moved around so its not clear that the problem was fixed by
> the spinlocks or the code reordering.  I'd rather know which it was.

The code re-ordering fixes the bug. The spinlocks are an unrelated change
that belong in a seperate diff.
