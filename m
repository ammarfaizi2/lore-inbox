Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbUKCIo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUKCIo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKCIo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:44:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:36763 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261475AbUKCIox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:44:53 -0500
Date: Wed, 3 Nov 2004 08:44:32 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Brent Casavant <bcasavan@sgi.com>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <239530000.1099435919@flay>
Message-ID: <Pine.LNX.4.44.0411030826310.6096-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Martin J. Bligh wrote:
> 
> Another way might be a tmpfs mount option ... I'd prefer that to a sysctl
> personally, but maybe others wouldn't. Hugh, is that nuts?

Only nuts if I am, I was going to suggest the same: the sysctl idea seems
very inadequate; a mount option at least allows the possibility of having
different tmpfs files allocated with different policies at the same time.

But I'm not usually qualified to comment on NUMA matters, and my tmpfs
maintenance shouldn't be allowed to get in the way of progress.  Plus
I've barely been attending in recent days: back to normality tomorrow.

Hugh

