Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVKDVO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVKDVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKDVO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:14:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35754 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750894AbVKDVO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:14:26 -0500
Date: Fri, 4 Nov 2005 22:14:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andy Nelson <andy@thermo.lanl.gov>
Cc: pj@sgi.com, akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051104211419.GA15888@elte.hu>
References: <20051104201248.GA14201@elte.hu> <20051104210418.BC56F184739@thermo.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104210418.BC56F184739@thermo.lanl.gov>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Nelson <andy@thermo.lanl.gov> wrote:

>   5) How does any of this stuff play with me having to rewrite my code to
>      use nonstandard language features? If I can't run using standard 
>      fortran, standard C and maybe for some folks standard C++ or Java,
>      it won't fly. 

it ought to be possible to get pretty much the same API as hugetlbfs via 
the 'hugetlb zone' approach too. It doesnt really change the API and FS 
side, it only impacts the allocator internally. So if you can utilize 
hugetlbfs, you should be able to utilize a 'special zone' approach 
pretty much the same way.

	Ingo
