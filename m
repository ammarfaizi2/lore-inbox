Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTKNTSD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTKNTSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:18:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:40366 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264303AbTKNTSB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:18:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
Date: Fri, 14 Nov 2003 11:10:12 -0800
User-Agent: KMail/1.4.1
References: <20031112233002.436f5d0c.akpm@osdl.org> <98290000.1068836914@flay>
In-Reply-To: <98290000.1068836914@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311141110.12671.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 11:08 am, Martin J. Bligh wrote:
> > - Several ext2 and ext3 allocator fixes.  These need serious testing on
> > big SMP.
>
> OK, ext3 survived a swatting on the 16-way as well. It's still slow as
> snot, but it does work ;-) No changes from before, methinks.
>
> Diffprofile for kernbench (-j) from ext2 to ext3 on mm3
>
>      27022    16.3% total
>      24069    53.3% default_idle
>        583     2.4% page_remove_rmap
>        539   248.4% fd_install
>        478   388.6% __blk_queue_bounce

What driver are you using ? Why are you bouncing ?

Thanks,
Badari
