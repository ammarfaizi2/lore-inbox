Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTBDMLk>; Tue, 4 Feb 2003 07:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTBDMLk>; Tue, 4 Feb 2003 07:11:40 -0500
Received: from ns.suse.de ([213.95.15.193]:30731 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267242AbTBDMLk>;
	Tue, 4 Feb 2003 07:11:40 -0500
Date: Tue, 4 Feb 2003 13:20:48 +0100
From: Dave Jones <davej@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] gcc 2.95 vs 3.21 performance
Message-ID: <20030204132048.D16744@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <336780000.1044313506@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <336780000.1044313506@flay>; from mbligh@aracnet.com on Mon, Feb 03, 2003 at 03:05:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 03:05:06PM -0800, Martin J. Bligh wrote:
 > People keep extolling the virtues of gcc 3.2 to me, which I'm
 > reluctant to switch to, since it compiles so much slower. But
 > it supposedly generates better code, so I thought I'd compile
 > the kernel with both and compare the results. This is gcc 2.95
 > and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
 > tests still use 2.95 for the compile-time stuff.
 > 
 > The results below leaves me distinctly unconvinced by the supposed 
 > merits of modern gcc's. Not really better or worse, within experimental
 > error. But much slower to compile things with.

What kernel was kernbench compiling ? The reason I'm asking is that
2.5s (and more recent 2.4.21pre's) will use -march flags for more
aggressive optimisation on newer gcc's.
If you want to compare apples to apples, make sure you choose
something like i386 in the processor menu, and then it'll always
use -march=i386 instead of getting fancy with things like -march=pentium4

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
