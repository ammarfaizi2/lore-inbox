Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWJEAhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWJEAhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWJEAhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:37:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59042 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751270AbWJEAhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:37:38 -0400
Date: Thu, 5 Oct 2006 10:37:12 +1000
From: David Chinner <dgc@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: David Chinner <dgc@sgi.com>, xfs-dev@sgi.com, xfs@oss.sgi.com,
       dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/3] Convert XFS inode hashes to radix trees
Message-ID: <20061005003712.GD3024@melbourne.sgi.com>
References: <20061003060610.GV3024@melbourne.sgi.com> <20061003212335.GA13120@tuatara.stupidest.org> <20061003222256.GW4695059__33273.3314754025$1159914338$gmane$org@melbourne.sgi.com> <p73y7rwynbg.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y7rwynbg.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 07:59:15PM +0200, Andi Kleen wrote:
> David Chinner <dgc@sgi.com> writes:
> > 
> > And yes, 64 bit systems are cheap, cheap, cheap so IMO this
> > functionality is really irrelevant moving forward. If it had come
> > along a couple of years ago then it would be different, but I think
> > mainstream technology is finally catching up with XFS so it's not a
> > critical issue anymore... ;)
> 
> One issue is that people often still run a lot of 32bit userland
> even with 64bit kernels.

Which is one of the reasons why XFS uses 32 bit inodes by default
even on 64 bit kernels. XFS does not use 64 bit inodes unless you
tell it to via the inode64 mount option....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
