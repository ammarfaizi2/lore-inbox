Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbRF1TnU>; Thu, 28 Jun 2001 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264092AbRF1TnK>; Thu, 28 Jun 2001 15:43:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16912 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264080AbRF1TnA>; Thu, 28 Jun 2001 15:43:00 -0400
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using
To: bernds@redhat.com (Bernd Schmidt)
Date: Thu, 28 Jun 2001 20:42:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mikpe@csd.uu.se (Mikael Pettersson),
        FrankZhu@viatech.com.cn, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106281937330.32164-100000@host140.cambridge.redhat.com> from "Bernd Schmidt" at Jun 28, 2001 07:39:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fhg1-0007WG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Intel specifically state that you cannot use CMOV without checking
> > for it. Its actually a gcc/binutils tool bug. The CPU is right.
> 
> How is that a gcc bug?  You tell the compiler to generate cmov, you run
> it on a CPU that doesn't have it, you get what you deserve.  There's
> really nothing the tools can do about that.

I tell gcc to buld for the 'i686' architecture definition. It in fact builds
for the i686 architecture assuming an optional feature. Intel's own PPro doc
is quite explicit that cmov could go away again in future chips.

So cmov should not have been in the 686 machine definition.

Alan

