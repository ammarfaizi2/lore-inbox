Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRF1SlQ>; Thu, 28 Jun 2001 14:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRF1SlG>; Thu, 28 Jun 2001 14:41:06 -0400
Received: from t2.redhat.com ([199.183.24.243]:28402 "EHLO
	host140.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261289AbRF1Sku>; Thu, 28 Jun 2001 14:40:50 -0400
Date: Thu, 28 Jun 2001 19:39:23 +0100 (BST)
From: Bernd Schmidt <bernds@redhat.com>
X-X-Sender: <bernds@host140.cambridge.redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <FrankZhu@viatech.com.cn>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using
 cyr ixIII
In-Reply-To: <E15FNWJ-0005xB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106281937330.32164-100000@host140.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Alan Cox wrote:

> > The problem is that VIA Cyrix III announces itself (via CPUID)
> > as a "family 6" processor, i.e. i686 compatible. This is not
> > completely accurate, since it doesn't implement the conditional
> > move instruction. [Yeah, I know there's a CPUID feature flag for
>
> Intel specifically state that you cannot use CMOV without checking
> for it. Its actually a gcc/binutils tool bug. The CPU is right.

How is that a gcc bug?  You tell the compiler to generate cmov, you run
it on a CPU that doesn't have it, you get what you deserve.  There's
really nothing the tools can do about that.


Bernd

