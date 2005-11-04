Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVKDP1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVKDP1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVKDP1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:27:01 -0500
Received: from dvhart.com ([64.146.134.43]:40882 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750709AbVKDP1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:27:00 -0500
Date: Fri, 04 Nov 2005 07:27:01 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Cc: bron@bronze.corp.sgi.com, pbadari@gmail.com, jdike@addtoit.com,
       rob@landley.net, nickpiggin@yahoo.com.au, gh@us.ibm.com, mingo@elte.hu,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <326590000.1131118021@[10.10.2.4]>
In-Reply-To: <20051104015250.42364430.pj@sgi.com>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com><200511021747.45599.rob@landley.net><43699573.4070301@yahoo.com.au><200511030007.34285.rob@landley.net><20051103163555.GA4174@ccure.user-mode-linux.org><1131035000.24503.135.camel@localhost.localdomain><20051103205202.4417acf4.akpm@osdl.org><20051103213538.7f037b3a.pj@sgi.com><20051103214807.68a3063c.akpm@osdl.org><20051103224239.7a9aee29.pj@sgi.com><20051103231019.488127a6.akpm@osdl.org><20051103234530.5fcb2825.pj@sgi.com><20051104000212.2e0e92bd.akpm@osdl.org> <20051104015250.42364430.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> We agree that my per-cpuset memory_reclaim_rate meter certainly hides
> more detail than the sorts of stats you are suggesting.  I thought that
> was good, so long as what was needed was still present.

But it's horribly specific to cpusets. If you want something multi-task,
would be better if it worked by more generic task groupings. 

M.
