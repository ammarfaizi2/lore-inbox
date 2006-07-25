Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWGYXIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWGYXIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWGYXIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:08:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:46749 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030240AbWGYXIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:08:30 -0400
Date: Tue, 25 Jul 2006 18:07:41 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 0 of 7] x86-64: Calgary IOMMU updates
Message-ID: <20060725230740.GF23966@us.ibm.com>
References: <patchbomb.1153846590@rhun.haifa.ibm.com> <200607260025.56903.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607260025.56903.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 12:25:56AM +0200, Andi Kleen wrote:
> On Tuesday 25 July 2006 18:56, Muli Ben-Yehuda wrote:
> > Hi Andi,
> > 
> > This patchset contains a few Calgary bug fixes (mostly in the error
> > handling) and a few harmless associated cleanups (e.g., rearranging
> > structures for better alignment). It would be good to get these,
> > especially the bug fixes, into 2.6.18.
> 
> How do these patches relate to the two earlier patches that Jon sent?

These patches are ontop of the patches I sent (and which Muli resent a
few days afterward).  Those patches fix a major problem and need to make
it into 2.6.18.

> 
> 2.6.18 is closed for anything but bug fixes for serious bugs.

This is mostly error path bugs and clean-up/code re-org (to save memory
and make things more cache friendly).  The changes are mostly minor.
If you are uncomfortable with applying them, we can separate patches 3,
4, and 5 (which are the bug fixes) from the rest and send those to you.
Is that more acceptable?

Thanks,
Jon

> -Andi
> 
