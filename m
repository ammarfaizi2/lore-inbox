Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSEVOhH>; Wed, 22 May 2002 10:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSEVOhG>; Wed, 22 May 2002 10:37:06 -0400
Received: from holomorphy.com ([66.224.33.161]:62098 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315178AbSEVOhE>;
	Wed, 22 May 2002 10:37:04 -0400
Date: Wed, 22 May 2002 07:36:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, andrea@suse.de,
        riel@surriel.com, torvalds@transmeta.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020522143651.GA14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"M. Edward Borasky" <znmeb@aracnet.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
	akpm@zip.com.au
In-Reply-To: <20020522085111.C20554@ds217-115-141-141.dedicated.hosteurope.de> <HBEHIIBBKKNOBLMPKCBBGEBEENAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 07:00:11AM -0700, M. Edward Borasky wrote:
> A few months ago, there was a flurry of reports from people having
> difficulties with memory management on large machines (ia32 over 4 GB). I've
> seen a lot of 2.4.x-yy kernels go by and much VM discussion, but what I'm
> *not* seeing is reports of either catastrophic behavior or its absence on
> large machines. I haven't had a chance to run my own test cases on the
> 2.4.18 kernel from Red Hat 7.3 yet, so I can't make any personal
> contribution to this discussion.

The catastrophic failures are still happening, in fact, the last
lse-tech conference call a week or two ago was dedicated at least in
part to them. The number of different ways in which these failures
occur is large, so it's taking a while for the iterations of whack-a-mole
game to converge to kernel stability. Andrea has probably been doing the
most visible stuff on this front with the recent bh/inode exhaustion
patches, with due credit to akpm as well for the unconditional bh
stripping patch.


Cheers,
Bill
