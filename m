Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbUKCVHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUKCVHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUKCVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:03:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:13528 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261886AbUKCVBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:01:50 -0500
Date: Wed, 03 Nov 2004 13:00:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brent Casavant <bcasavan@sgi.com>, Andi Kleen <ak@suse.de>,
       colpatch@us.ibm.com
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <276730000.1099515644@flay>
In-Reply-To: <Pine.SGI.4.58.0411031021160.79310@kzerza.americas.sgi.com>
References: <239530000.1099435919@flay> <Pine.LNX.4.44.0411030826310.6096-100000@localhost.localdomain><20041103090112.GJ8907@wotan.suse.de> <Pine.SGI.4.58.0411031021160.79310@kzerza.americas.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, November 03, 2004 10:32:56 -0600 Brent Casavant <bcasavan@sgi.com> wrote:

> On Wed, 3 Nov 2004, Andi Kleen wrote:
> 
>> If you want to go more finegraid then you can always use numactl
>> or even libnuma in the application.  For a quick policy decision a sysctl
>> is fine imho.
> 
> OK, so I'm not seeing a definitive stance by the interested parties
> either way.  So since the code's already done, I'm posting the sysctl
> method, and defaulting to on.  I assume that if we later decide that
> a mount option was correct after all, that it's no big deal to axe the
> sysctl?

Matt has volunteered to write the mount option for this, so let's hold
off for a couple of days until that's done.

M

