Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSDDMsq>; Thu, 4 Apr 2002 07:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSDDMsh>; Thu, 4 Apr 2002 07:48:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24582 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313162AbSDDMs2>; Thu, 4 Apr 2002 07:48:28 -0500
Date: Thu, 4 Apr 2002 13:48:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404134816.A29272@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0204041245340.1475-100000@einstein.homenet> <Pine.NEB.4.44.0204041423450.7845-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 02:31:48PM +0200, Adrian Bunk wrote:
> On Thu, 4 Apr 2002, Tigran Aivazian wrote:
> > sense, wrong. Namely, in the sense that it is inconsistent with the
> > similar situation in the case of libraries or even system calls. I don't
> 
> The COPYING file of Linux contains an explicit permission to use 'kernel
> services by normal system calls' and that this 'does *not* fall under the
> heading of "derived work"'. As stated in my previous mail in this thread
> I'm still wondering where the allowance for binary-only modules to link
> with the kernel is hidden.

It isn't written down anywhere - this is one of the major problems here.
If you ask Linus, Linus will say "sure, it's fine to have binary-only
modules", but it's not explicitly documented in the license document
and as such everyone who contributes code to the kernel doesn't have
to agree to this.

Unfortunately, putting it into the license now could be construed as a
change of terms, which would require everyone whose code is exported via
EXPORT_SYMBOL to agree (and there's little chance of that happening...)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

