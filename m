Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVKJNWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVKJNWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKJNWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:22:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:35302 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750847AbVKJNWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:22:21 -0500
Subject: Re: merge status
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, James.Bottomley@SteelEye.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       jgarzik@pobox.com, tony.luck@intel.com, bcollins@debian.org,
       scjody@modernduck.com, dwmw2@infradead.org, rolandd@cisco.com,
       davej@codemonkey.org.uk, sfrench@us.ibm.com
In-Reply-To: <20051110013055.77120a56.akpm@osdl.org>
References: <20051109133558.513facef.akpm@osdl.org>
	 <1131573041.8541.4.camel@mulgrave>
	 <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
	 <1131575124.8541.9.camel@mulgrave> <20051109150141.0bcbf9e3.akpm@osdl.org>
	 <20051110084025.GW3699@suse.de> <20051110005653.3cb2c90f.akpm@osdl.org>
	 <20051110092241.GY3699@suse.de>  <20051110013055.77120a56.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 07:22:16 -0600
Message-Id: <1131628936.9384.9.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 01:30 -0800, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Thu, Nov 10 2005, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > >  It's more of a "I don't feel like spending 1-2 hours making and testing
> > > >  a -mm version"
> > > 
> > > There shouldn't be a need for special -m version of patches.  Very usually
> > > the diff-against-linus can be made to work quite easily.  Sufficiently
> > > easily that I resync with all the git trees a couple of times a day.
> > 
> > Often the patch itself may not take too much work, but you still need to
> > set up a -mm test directory, compile, boot, and test the stuff.
> 
> Most of the other git-tree maintainers don't bother with any of that. 
> acpi, agp, alsa, arm, ...  xfs.  The trees which have special -mm branches
> are just drm, ieee1394, jfs, mips and netdev.

jfs doesn't really maintain a separate -mm branch.  I set up the tree to
be flexible if I ever had a reason to hold something back from the Linus
tree, but in reality, -mm is equal to HEAD, and the -linus branch is
usually the same when I ask for it to be pulled.

-- 
David Kleikamp
IBM Linux Technology Center

