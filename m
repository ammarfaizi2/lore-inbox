Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWHaDTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWHaDTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 23:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWHaDTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 23:19:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49614 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751352AbWHaDT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 23:19:29 -0400
Date: Thu, 31 Aug 2006 13:19:02 +1000
From: Nathan Scott <nathans@sgi.com>
To: Masayuki Saito <m-saito@tnes.nec.co.jp>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix i_state of inode is changed after the inode is freed [try #2]
Message-ID: <20060831131902.H3208450@wobbly.melbourne.sgi.com>
References: <20060824171653.C3003989@wobbly.melbourne.sgi.com> <20060831114423m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060831114423m-saito@mail.aom.tnes.nec.co.jp>; from m-saito@tnes.nec.co.jp on Thu, Aug 31, 2006 at 11:44:23AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 11:44:23AM +0900, Masayuki Saito wrote:
> Hi, Nathan
> 
> Are the patches going to be merged?

Yep, they're queued up for 2.6.19.  Since it was a race found
only on testing with a ramdisk (iirc) it didn't really seem to
me like they needed to be rushed through for a 2.6.18-rc.  The
race has also been there for the entire lifetime of the Linux
XFS port... so, not urgent (and not risk free either).

cheers.

-- 
Nathan
