Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSEDJiz>; Sat, 4 May 2002 05:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSEDJiy>; Sat, 4 May 2002 05:38:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55560 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292730AbSEDJix>; Sat, 4 May 2002 05:38:53 -0400
Date: Sat, 4 May 2002 10:38:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020504103843.B17918@flint.arm.linux.org.uk>
In-Reply-To: <15571.33592.365558.215598@argo.ozlabs.ibm.com> <23023.1020502982@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 07:03:02PM +1000, Keith Owens wrote:
> md5sums alone are not enough, people touch source or header files, even
> config options and expect objects to be rebuilt, timestamps are
> required as well.  A change to the KBUILD_SRCTREE_nnn environment
> variables adds or deletes entire trees.  So phase1 is still required,
> to find all the files in all the trees and get their current
> timestamps.  "Optimizing" will not save any time there, kbuild always
> needs current timestamp data.

So you're *reading* all source files in the kernel tree each time you
kick off a build?  Do you have shares in a SDRAM memory manufacturer
by any chance?

If that's the case, I'd rather the existing 2.4 build system stayed.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

