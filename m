Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131791AbRCUVMf>; Wed, 21 Mar 2001 16:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131793AbRCUVMZ>; Wed, 21 Mar 2001 16:12:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131791AbRCUVMW>; Wed, 21 Mar 2001 16:12:22 -0500
Subject: Re: Q: "kapm-idled" and CPU usage
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 21 Mar 2001 21:14:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        gc@mandrakesoft.com (Guillaume Cottenceau)
In-Reply-To: <3AB50177.47489C00@mandrakesoft.com> from "Jeff Garzik" at Mar 18, 2001 01:41:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14fpw7-00012U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Several months ago, kapmd was renamed to kapm-idled in an attempt to
> signal users that it was a special process, and that its CPU time wasn't
> "real CPU time."  This hasn't silenced the bug reports and confusion.

And instrumenting the number of calls to the apm idle function I am
not convinced that apm idle is working for all laptops as other people have
claimed.
