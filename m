Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWFIXzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWFIXzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbWFIXzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:55:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030555AbWFIXzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:55:47 -0400
Date: Fri, 9 Jun 2006 16:54:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Jeff Garzik <jeff@garzik.org>, Dave Jones <davej@redhat.com>,
       Theodore Tso <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060609233754.GO5964@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.64.0606091652280.5498@g5.osdl.org>
References: <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
 <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
 <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com>
 <20060609205036.GI7420@redhat.com> <4489E8EF.5020508@garzik.org>
 <20060609225604.GK5964@schatzie.adilger.int> <4489FFB8.3070203@garzik.org>
 <20060609233754.GO5964@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Andreas Dilger wrote:
>
> OK, you're right.  We'll continue working on the fork (namely ext3) and
> when people who care consider those features stable enough they can port
> them to ext2. :-)

You're totally inappropriately focused on this whole "porting back" side.

THE WHOLE POINT IS TO NOT PORT THINGS BACK.

There is absolutely no point in any ext4 work being ported back to ext3, 
since the whole point is a fork like this is to have the "stable" thing.

Yes, old bugs happen and sometimes exist in both, but hey, the number of 
duplicated bugs - while not non-zero - is still less than the bugs 
introduced by trying to keep things in sync.

		Linus
