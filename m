Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSFKI0q>; Tue, 11 Jun 2002 04:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSFKI0p>; Tue, 11 Jun 2002 04:26:45 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:60942 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316951AbSFKI0o>; Tue, 11 Jun 2002 04:26:44 -0400
Date: Tue, 11 Jun 2002 09:26:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020611092637.C1346@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com> <3D0599AE.7080809@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 08:33:18AM +0200, Martin Dalecki wrote:
> 6. In esp. ARM seems to be much better off with GCC 3.1 then anything else.

Not yet proven.  Only a minority of people are using gcc 3.1 compared
to gcc 2.95.x to build ARM kernels currently.

We've already found a few things that need changing in 2.5 (which haven't
been updated in 2.4 yet) that are needed for gcc 3.1 to build the kernel
properly.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

