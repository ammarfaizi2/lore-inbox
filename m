Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283102AbRK2JBH>; Thu, 29 Nov 2001 04:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283104AbRK2JA6>; Thu, 29 Nov 2001 04:00:58 -0500
Received: from [213.237.118.153] ([213.237.118.153]:27520 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S283102AbRK2JAw>;
	Thu, 29 Nov 2001 04:00:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: 3 Questions
Date: Thu, 29 Nov 2001 09:59:29 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E169B3r-0005yK-00@the-village.bc.nu>
In-Reply-To: <E169B3r-0005yK-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E169N2Y-0000zS-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 November 2001 21:12, Alan Cox wrote:
> > 3) Aurora wants to track the driver in its source control system, but
> > they have ISO 900X procedures that require maintaining the build
> > environment under CVS.  The build environment is basically the kernel
> > against which it is developed.  But new developer kernels are released
> > fairly regularly (unlike new versions of Solaris or True64).  Do
> > maintainers of such driver software commonly maintain development
> > environments across a complete range (e.g., all 2.4.* kernels)?  Is
> > there a FAQ with recommendations to help a hardware vendor deal with
> > the nitty gritty details of making sure its driver software works
> > properly across such a range of rapidly changing development
> > environments?
>
> Generally driver vendors only certify/support against "standard" vendor
> released kernels. So instead of Linux they support "SuSE 7.3" "Red Hat 7.2"
> etc..
>
> Most also make a clear distinction between what is submitted to the GPL and
> hacked about under the GPL, and what they will provide any guarantee on.
>
> Think of it like a car.
> 	The engine is only supported for the car it was designed for
> 	You can rebore the engine but you wont get support
> 	You can stick the engine in a different car but you wont get support
>

Unless they release it GPL, then it might be included in the kernel right? 
And "the nitty gritty details of making sure its driver software works
properly across such a range of rapidly changing development
environments" taken care of by the users of the driver.  They can even track 
it by CVS, by requesting all patches against the driver to be submitted to 
them.

They asked for official recommendations, shouldnt the primary recommandation 
not be to open source it, even if some vendors wont?

Regards
