Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285429AbRLSUD7>; Wed, 19 Dec 2001 15:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285435AbRLSUDt>; Wed, 19 Dec 2001 15:03:49 -0500
Received: from ns01.netrox.net ([64.118.231.130]:9346 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S285429AbRLSUDb>;
	Wed, 19 Dec 2001 15:03:31 -0500
Subject: Re: gcc 3.0.2/kernel details (-O issue)
From: Robert Love <rml@tech9.net>
To: Martin Devera <devik@cdi.cz>
Cc: Chris Meadors <clubneon@hereintown.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz>
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 19 Dec 2001 15:03:30 -0500
Message-Id: <1008792213.806.36.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-19 at 14:39, Martin Devera wrote:
> It is interesting that 2.2 can be done with -O. Also I'd expect
> errors during compilation and not silent crash...

Well, you certainly won't get errors, because compiler optimizations
shouldn't change expected syntax.

-O2 is the standard optimization level for the kernel; everything is
compiled via it.  When developers test their code, nuances that the
optimization introduce are accepted.  Removing the optimization may
break those expectations.  Thus the kernel requires it.

	Robert Love

