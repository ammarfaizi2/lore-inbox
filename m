Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965272AbWFIUvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbWFIUvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWFIUvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:51:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965253AbWFIUvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:51:07 -0400
Date: Fri, 9 Jun 2006 16:50:36 -0400
From: Dave Jones <davej@redhat.com>
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609205036.GI7420@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
	Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609203803.GF3574@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 01:38:03PM -0700, Joel Becker wrote:
 > that the older code cannot read.  Alex claims people just shouldn't use
 > "-o extents", but the fact is their distro will choose it for them.

.. on partitions over a certain size, which couldn't be read with
older ext3 filesystems _anyway_

Enabling it by default on partitions of a size less than those
that need extents seems to be somewhat pointless to me?

Am I missing something fundamental that precludes the use of both
extent-based and current existing filesystems from the same code
simultaneously ?

		Dave

-- 
http://www.codemonkey.org.uk
