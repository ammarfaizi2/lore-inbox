Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSFKJ3G>; Tue, 11 Jun 2002 05:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316973AbSFKJ3F>; Tue, 11 Jun 2002 05:29:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11023 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316971AbSFKJ3E>; Tue, 11 Jun 2002 05:29:04 -0400
Date: Tue, 11 Jun 2002 10:28:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020611102859.F1346@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com> <3D0599AE.7080809@evision-ventures.com> <20020611092637.C1346@flint.arm.linux.org.uk> <3D05B61F.4010609@evision-ventures.com> <20020611100634.D1346@flint.arm.linux.org.uk> <3D05BE5B.1000705@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 11:09:47AM +0200, Martin Dalecki wrote:
> U¿ytkownik Russell King napisa³:
> > GCC 3.x introduces the dodgy practice of removing the frame pointer
> > from every function despite telling the compiler not to with
> > -fno-omit-frame-pointer.  It's also contary to the GCC documentation
> > when it interferes with debugging.
> 
> This can not be true - since otherwise task switching wouldn't work
> at all!

It is indeed true.  From your comment, it looks like you don't understand
the ARM architecture/what a frame pointer is.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

