Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261999AbTCHCEs>; Fri, 7 Mar 2003 21:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261997AbTCHCEs>; Fri, 7 Mar 2003 21:04:48 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:6133 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261990AbTCHCEr>; Fri, 7 Mar 2003 21:04:47 -0500
Date: Fri, 7 Mar 2003 18:15:05 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       cherry@osdl.org, rddunlap@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308021505.GH2835@ca-server1.us.oracle.com>
References: <20030307221217.GB21315@kroah.com> <20030307225517.GF2835@ca-server1.us.oracle.com> <20030307225710.A18005@infradead.org> <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net> <20030307233636.A19260@infradead.org> <20030307154624.12105fa3.akpm@digeo.com> <20030307235454.A19662@infradead.org> <20030308014911.GG2835@ca-server1.us.oracle.com> <20030308015805.GA23591@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308015805.GA23591@kroah.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 05:58:06PM -0800, Greg KH wrote:
> <shameless plug>
> 
> http://www.linuxsymposium.org/2003/view_abstract.php?talk=94

	I personally think that /dev population should exist in
userspace as well.  I *hope* you mean to populate a regular filesystem
with device nodes that your system manages.
	That said, however /dev is populated, we need the dev_t space to
represent the devices :-)

Joel

-- 

"Anything that is too stupid to be spoken is sung."  
        - Voltaire

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
