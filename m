Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVIKUDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVIKUDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 16:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVIKUDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 16:03:47 -0400
Received: from silver.veritas.com ([143.127.12.111]:12459 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750780AbVIKUDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 16:03:47 -0400
Date: Sun, 11 Sep 2005 21:03:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: 2.6.13-mm2
In-Reply-To: <20050911123627.2551a057.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509112055530.3611@goblin.wat.veritas.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509111903.38938.rjw@sisk.pl>
 <20050911123627.2551a057.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Sep 2005 20:03:40.0471 (UTC) FILETIME=[E7669470:01C5B70B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> >  Could you please reintroduce the yenta-free_irq-on-suspend.patch (attached)
> >  into -mm?  My box does not resume from disk without it.
> 
> No probs.
> 
> Daniel, do you remember why we decided to drop it?  What should we do about
> this?  Thanks.

I remember well.  My laptop does not APM resume from RAM with it.
I've just rechecked and that's still the case.  I did try various patches
from Rafael to help him work it out, but it remained a puzzle.
And I admit, it is his turn to resume this month.

Hugh
