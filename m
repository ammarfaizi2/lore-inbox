Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143518AbRA1Qds>; Sun, 28 Jan 2001 11:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143524AbRA1Qdh>; Sun, 28 Jan 2001 11:33:37 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:9997
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S143518AbRA1Qd2>; Sun, 28 Jan 2001 11:33:28 -0500
Date: Sun, 28 Jan 2001 08:33:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Peter Horton <pdh@colonel-panic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8 losing pages
In-Reply-To: <20010128121147.A1877@colonel-panic.com>
Message-ID: <Pine.LNX.4.10.10101280831350.26765-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Peter Horton wrote:

> Okay, scratch that. It does still happen when there's no swap, but for
> some reason it happens a lot less often. Looks like it's timing related,
> it only fails when using 7200rpm drives, not older 5400rpm ones (even
> though they too are using UDMA33). I've ruled out the filing system, the
> IDE controller, the drives and the RAM, so that leaves the kernel or the
> CPU - I'll try and beg/borrow/steal another CPU and try that. I can
> compile kernels / run X whilst the test is running without a problem so it
> looks like it's the bulk write that's the problem.

Peter, did the scratch-test series pass or fail?
Did it report any bit failures on the check?

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
