Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbTAPWec>; Thu, 16 Jan 2003 17:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267309AbTAPWec>; Thu, 16 Jan 2003 17:34:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:5623 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267306AbTAPWeb>;
	Thu, 16 Jan 2003 17:34:31 -0500
Date: Thu, 16 Jan 2003 14:36:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Theurer <habanero@us.ibm.com>
Subject: Re: [PATCH] (0/3) NUMA aware scheduler
Message-ID: <125260000.1042756562@flay>
In-Reply-To: <Pine.LNX.4.44.0301161225260.1175-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301161225260.1175-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Applied. 

Thank you!
 
> I also have to say that I hope this means that the HT-specific scheduler 
> stuff will go away. HT _should_ be just another NuMA issue, and right now 
> the two seem to be just slightly different ways of covering the same 
> needs.

Yup, Andrew Theurer from our performance team has been working on this.
Initial results look encouraging.

> However, I'm going away for two weeks starting tomorrow, so even if there 
> is some experimental HT/NUMA patch, I don't want it at this point. The 
> NUMA scheduler merge is more of a "get the infrastructure in place" thing 
> for me right now.

Absolutely. Hopefully by the time you return we'll have a structure for
hyperthreading in place that's reasonably tuned ;-)

There's some more tuning and tweaking we could do to the NUMA machines as
well (I'm looking at how to implement Ingo's feedback), but I'm convinced
the infrastructure is correct.

Thanks,

M.

