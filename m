Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291701AbSBTI0l>; Wed, 20 Feb 2002 03:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291689AbSBTI0W>; Wed, 20 Feb 2002 03:26:22 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:3832
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S291693AbSBTI0O>; Wed, 20 Feb 2002 03:26:14 -0500
Message-ID: <3C735D97.70809@debian.org>
Date: Wed, 20 Feb 2002 09:25:59 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nicholas@petreley.com
CC: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NVidia driver with 2.5
In-Reply-To: <fa.fhm0v6v.d02k8d@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Petreley wrote:

> I haven't tried the NVidia driver with the latest 2.5 kernels but I had 
> no problem modifying nv.c and making the driver work with earlier diffs. 
> The trick is to just fudge the code in os-interface.c to make it 
> compile, and then configure XF86Config-4 not to use the NVidia agp 
> driver (use the kernel agpgart instead). That way the fudged 
> os-interface.c code doesn't even get called, as far as I know. It worked 
> for me (at least, as I said, as of a few diffs ago).
> 
> Don't even try to use the bogus os-interface.c changes by activating 
> NV's agp or it will bomb, and I take no responsibility for the damage. 
> In fact, I take no responsibility for the damage no matter what you do 
> with this info. ;-)
> 
> Having said all that, I use 2.4.18-rc2-ac1, which only requires a few 
> modifications (IIRC, just the minor() stuff).  But here are some diffs 
> against NVidia drivers 2314 for those who are suicidal or just curious.
> 
> 
> --- nv.c.original    Wed Jan 16 09:47:27 2002
> +++ nv.c.vma    Mon Jan 28 17:05:26 2002
> 
> --- os-interface.c.original    Mon Feb  4 22:42:44 2002
> +++ os-interface.c.vma    Thu Jan 31 23:35:59 2002

Put explicity that your code is GPL, so that we can use it
(private use we can link with all code), but nvidia cannot
use your work unless they release the source.

	giacomo

