Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVATAOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVATAOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVATAMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:12:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50854 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261988AbVATADe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:03:34 -0500
Date: Thu, 20 Jan 2005 10:59:55 +1100
From: Nathan Scott <nathans@sgi.com>
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple page allocation errors in 2.6.10
Message-ID: <20050119235955.GC887@frodo>
References: <20050119081132.GD4494@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119081132.GD4494@hpc2n.umu.se>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:11:32AM +0100, Ake wrote:
> Hi!
> I'm getting multiple page allocation errors under high load.
> Should i worry about them?
> 
> nfsd: page allocation failure. order:4, mode:0x50
> ...[xfs stack]...

No, this one is OK and was a recoverable situation.
We need to do some (non-trivial) work in XFS to
prevent high order allocations in this situation
altogether, but your system should still be fine.

cheers.

-- 
Nathan
