Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRK1UEJ>; Wed, 28 Nov 2001 15:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280591AbRK1UDu>; Wed, 28 Nov 2001 15:03:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1552 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280588AbRK1UDn>; Wed, 28 Nov 2001 15:03:43 -0500
Subject: Re: 3 Questions
To: ThorsProvoni@aol.com (Joachim Martillo)
Date: Wed, 28 Nov 2001 20:12:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, martillo@telfordtools.com
In-Reply-To: <3C053888.89D3FD82@aol.com> from "Joachim Martillo" at Nov 28, 2001 02:18:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169B3r-0005yK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3) Aurora wants to track the driver in its source control system, but
> they have ISO 900X procedures that require maintaining the build
> environment under CVS.  The build environment is basically the kernel
> against which it is developed.  But new developer kernels are released
> fairly regularly (unlike new versions of Solaris or True64).  Do
> maintainers of such driver software commonly maintain development
> environments across a complete range (e.g., all 2.4.* kernels)?  Is
> there a FAQ with recommendations to help a hardware vendor deal with
> the nitty gritty details of making sure its driver software works
> properly across such a range of rapidly changing development
> environments?

Generally driver vendors only certify/support against "standard" vendor
released kernels. So instead of Linux they support "SuSE 7.3" "Red Hat 7.2"
etc..

Most also make a clear distinction between what is submitted to the GPL and
hacked about under the GPL, and what they will provide any guarantee on. 

Think of it like a car.
	The engine is only supported for the car it was designed for
	You can rebore the engine but you wont get support
	You can stick the engine in a different car but you wont get support

Alan
