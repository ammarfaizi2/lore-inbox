Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285309AbRLXUiG>; Mon, 24 Dec 2001 15:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285310AbRLXUh4>; Mon, 24 Dec 2001 15:37:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56837 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285309AbRLXUhs>; Mon, 24 Dec 2001 15:37:48 -0500
Subject: Re: [patch] Assigning syscall numbers for testing
To: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 24 Dec 2001 20:46:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dledford@redhat.com (Doug Ledford),
        kaos@ocs.com.au (Keith Owens), bcrl@redhat.com (Benjamin LaHaise),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011224193124.F2110@flint.arm.linux.org.uk> from "Russell King" at Dec 24, 2001 07:31:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ibzl-00058g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Negative numbers are safe until Linus has 2^31 syscalls, at which point
> > quite frankly we would have a few other problems including the fact that
> > the syscall table won't fit in kernel mapped memory.
> 
> Please leave the allocation of the exact number space to the port
> maintainers discression.

Sorry.. I'm talking about x86 here. Linus is the x86 port maintainer as
well so we have to plan it out that way. For non x86 sure.

Alan
