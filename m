Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293160AbSB1Dyu>; Wed, 27 Feb 2002 22:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293145AbSB1Dxy>; Wed, 27 Feb 2002 22:53:54 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:9116 "EHLO
	pimout1-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S293141AbSB1Dxr>; Wed, 27 Feb 2002 22:53:47 -0500
Subject: Re: Kernel module ethics.
From: Richard Thrapp <rthrapp@sbcglobal.net>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: Allo! Allo! <lachinois@hotmail.com>,
        linux-kernel
	 <linux-kernel@vger.kernel.org>
In-Reply-To: <20020228005152.GB8858@arthur.ubicom.tudelft.nl>
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
	<Pine.LNX.3.95.1020227164752.16918A-100000@chaos.analogic.com> 
	<20020228005152.GB8858@arthur.ubicom.tudelft.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 21:59:46 -0600
Message-Id: <1014868787.3565.127.camel@wizard>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-27 at 18:51, Erik Mouw wrote:
> On Wed, Feb 27, 2002 at 05:23:41PM -0500, Richard B. Johnson wrote:
> > So, enter the compromise. Make your proprietary stuff in separate file(s)
> > known only to your company. This keeps them trade secret. Compile them
> > into a library. Provide that library with your module. The functions
> > contained within that library should be documented as well as the
> > calling parameters (a header file). This helps GPL maintainers
> > determine if your library is broken.
> 
> Brilliant, this violates section 2b from the GPLv2. If that's OK with
> you, see a lawyer first.

Hasn't it been said (by people in control) that binary only modules are
okay to link into the kernel, or do I remember incorrectly?  How is this
different from a binary only module?  Release an open-source component
under a BSD license, or even a commercial license if you like, along
with a closed source component.  Link the two together, and finally
insmod your non-GPL amalgamation into the kernel.

Anyway, you're not distributing your kernel with your module linked in,
so you're not distributing a derivative of a GPLed program, so by my
understanding section 2b doesn't apply.  Comments?

-- 
Richard Thrapp


