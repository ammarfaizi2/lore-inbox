Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311602AbSCNMgD>; Thu, 14 Mar 2002 07:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311604AbSCNMfx>; Thu, 14 Mar 2002 07:35:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27964 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311602AbSCNMfl>; Thu, 14 Mar 2002 07:35:41 -0500
Date: Thu, 14 Mar 2002 13:37:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020314133718.L1273@dualathlon.random>
In-Reply-To: <20020314032801.C1273@dualathlon.random> <20020314133223.B19636@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314133223.B19636@suse.de>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 01:32:23PM +0100, Dave Jones wrote:
> On Thu, Mar 14, 2002 at 03:28:01AM +0100, Andrea Arcangeli wrote:
>  > Only in 2.4.19pre3aa2: 21_pte-highmem-f00f-1
>  > 
>  > 	vmalloc called before smp_init was an hack, right way
>  > 	is to use fixmap. CONFIG_M686 doesn't mean much these
>  > 	days, but it's ok and probably most vendors will use it
>  > 	for the smp kernels, so it will save 4096 of the vmalloc space.
>  > 	I just didn't wanted to clobber the code with || CONFIG_K7 ||
>  > 	CONFIG_... | ... given all the other f00f stuff is also
>  > 	conditional only to M686 and probably nobody bothered to compile
>  > 	it out for my same reason 
> 
>  Brian Gerst had a patch a few months back to introduce a CONFIG_F00F
>  if a relevant CONFIG_Mxxx was chosen[1]. It never got applied anywhere, but makes
>  more sense than the CONFIG_M686 we currently use. 

indeed.

Andrea
