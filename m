Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSGXJNL>; Wed, 24 Jul 2002 05:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSGXJNL>; Wed, 24 Jul 2002 05:13:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20997 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315406AbSGXJNL>; Wed, 24 Jul 2002 05:13:11 -0400
Date: Wed, 24 Jul 2002 10:16:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "D. A. M. Revok" <marvin@synapse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Message-ID: <20020724101620.A25115@flint.arm.linux.org.uk>
References: <20020724082557Z318273-685+17059@vger.kernel.org> <20020724084749.GC15043@dreams.soze.net> <20020724090042Z315293-686+2972@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724090042Z315293-686+2972@vger.kernel.org>; from marvin@synapse.net on Wed, Jul 24, 2002 at 05:03:52AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 05:03:52AM -0400, D. A. M. Revok wrote:
> Oh, fucking great, /usr/include/asm /isn't/ a symlink to 
> /usr/src/linux/include/asm, it's its own directory.

That's 100% correct.  /usr/include/asm and /usr/include/linux are supposed
to be the kernel headers glibc was compiled with, not the kernel headers
for the kernel you're trying to build.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

