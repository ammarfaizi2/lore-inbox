Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSGXJW5>; Wed, 24 Jul 2002 05:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSGXJW5>; Wed, 24 Jul 2002 05:22:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27141 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315717AbSGXJW5>; Wed, 24 Jul 2002 05:22:57 -0400
Date: Wed, 24 Jul 2002 10:26:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "D. A. M. Revok" <marvin@synapse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Message-ID: <20020724102606.B25115@flint.arm.linux.org.uk>
References: <20020724082557Z318273-685+17059@vger.kernel.org> <20020724090042Z315293-686+2972@vger.kernel.org> <20020724101620.A25115@flint.arm.linux.org.uk> <E17XIMe-0001kA-00@caramon.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17XIMe-0001kA-00@caramon.arm.linux.org.uk>; from marvin@synapse.net on Wed, Jul 24, 2002 at 05:23:12AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 05:23:12AM -0400, D. A. M. Revok wrote:
> Oh, I didn't know that. . .
>   How's it supposed to know which version to include if there are 2 versions. 
> . . hmmm . . . probably by specifying somesort of include-path that puts 'em 
> in order-of-preference, then.

When building a kernel, paths specified with the gcc -I flag are searched
first, then the default include directory paths.

In later kernels, gcc is told not to use the default include directory
paths to stop it looking there and picking up an old header file.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

