Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSGYHxv>; Thu, 25 Jul 2002 03:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318340AbSGYHxv>; Thu, 25 Jul 2002 03:53:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28687 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317619AbSGYHxu>; Thu, 25 Jul 2002 03:53:50 -0400
Date: Thu, 25 Jul 2002 08:57:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Brad Hards <bhards@bigpond.net.au>
Cc: "D. A. M. Revok" <marvin@synapse.net>, linux-kernel@vger.kernel.org
Subject: Re: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Message-ID: <20020725085702.C7336@flint.arm.linux.org.uk>
References: <20020724082557Z318273-685+17059@vger.kernel.org> <20020724090042Z315293-686+2972@vger.kernel.org> <20020724101620.A25115@flint.arm.linux.org.uk> <200207251432.52687.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207251432.52687.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Thu, Jul 25, 2002 at 02:32:52PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 02:32:52PM +1000, Brad Hards wrote:
> Some applications talk to the kernel (eg via ioctl()). This is related to
> the kernel version that is running (not anything to do with the libs).

And ioctl() is an evil interface, and anything which changes in an
already defined ioctl is an ABI change, which aren't allowed in stable
kernel series.

> 3. Things that are related to the kernel that is running.
> This is probably /usr/include/linux

No.  Search the lkml archives.  You'll find several people, including
Linus telling people otherwise.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

