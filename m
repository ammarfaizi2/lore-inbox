Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbWFIVKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbWFIVKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWFIVKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:10:22 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:23257 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030489AbWFIVKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:10:19 -0400
Date: Fri, 9 Jun 2006 14:09:34 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Dave Jones <davej@redhat.com>, Theodore Tso <tytso@mit.edu>,
       Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609210934.GH3574@ca-server1.us.oracle.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
	Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609205036.GI7420@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609205036.GI7420@redhat.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 04:50:36PM -0400, Dave Jones wrote:
> On Fri, Jun 09, 2006 at 01:38:03PM -0700, Joel Becker wrote:
>  > that the older code cannot read.  Alex claims people just shouldn't use
>  > "-o extents", but the fact is their distro will choose it for them.
> 
> .. on partitions over a certain size, which couldn't be read with
> older ext3 filesystems _anyway_

	Certainly that would be fine.  Is that what will actually
happen?  Experience says no.  Even if you get it right in your distro,
not all distros will.  Heck, can you promise me that your distro will
provide e2fsprogs updates to its older releases so that multiboot will
continue to work?

Joel

-- 

"Behind every successful man there's a lot of unsuccessful years."
        - Bob Brown

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
