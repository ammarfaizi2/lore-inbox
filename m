Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTAPLYr>; Thu, 16 Jan 2003 06:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbTAPLYr>; Thu, 16 Jan 2003 06:24:47 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:56473 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266540AbTAPLYq>;
	Thu, 16 Jan 2003 06:24:46 -0500
Date: Thu, 16 Jan 2003 11:30:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Joshua M. Kwan" <joshk@mspencer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] X losing keyboard
Message-ID: <20030116113041.GA21239@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Joshua M. Kwan" <joshk@mspencer.net>, linux-kernel@vger.kernel.org
References: <20030116042853.GA1636@fuuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116042853.GA1636@fuuma>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 08:28:53PM -0800, Joshua M. Kwan wrote:
 > X loses the keyboard after switching to a TTY in 2.5.58-dj1-bk and then 
 > back to X. This is 100% reproducible. Is this a known bug?

I've been meaning to investigate - for me quitting X causes the machine
to just die completely. On two of my test boxes. I'm suspecting that
may be frame buffer related however.
There shouldn't be any patches in my tree to the input stuff any more,
so I'm a little puzzled. There are some console bits that I should 
probably just drop though.

 > Also, I get a lot of MTRR 1 and MTRR 2 not used notices after I quit X. 
 > But the performance seems the same either way (X performance compared 
 > between 2.4 and 2.5 kernels,) so is this a false positive?

Yep, I spotted those too. They only started appearing recently,
not sure what the meaning of them is.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
