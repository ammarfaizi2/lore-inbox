Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTD1WWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTD1WWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:22:47 -0400
Received: from holomorphy.com ([66.224.33.161]:18376 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261411AbTD1WWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:22:45 -0400
Date: Mon, 28 Apr 2003 15:34:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428223453.GV30441@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de> <3EAD5C44.103@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD5C44.103@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Nobody is doing that. pgcl is 2.5 only and seems to be still quite instable.
>> Also it's extremly intrusive.

On Mon, Apr 28, 2003 at 09:52:20AM -0700, Dave Hansen wrote:
> Bill will probably wake up any time now and chime in, but don't forget
> all of the drivers.
> # grep -r PAGE_SIZE drivers/ | wc -l
> 893
> Each one of those needs to be audited before pgcl is acceptable to a
> wide audience.  We've already seen plenty of stuff that breaks.  ext2/3
> look to be all right, but I know that JFS is broken.

I don't have a good estimate for speed-of-processing on the driver front.
My current guesstimates are based on something around 5 drivers a day per
person.


-- wli
