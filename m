Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUG3AwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUG3AwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267560AbUG3Av7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:51:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19893 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267549AbUG3Avd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:51:33 -0400
Date: Thu, 29 Jul 2004 20:51:27 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: Andrew Morton <akpm@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040729142829.2a75c9b9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407292050360.9228@dhcp030.home.surriel.com>
References: <20040729100307.GA23571@devserv.devel.redhat.com>
 <20040729142829.2a75c9b9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Andrew Morton wrote:

> I seem to recall that Andrea identified reasons why per-user mlock
> limits were fundamentally broken/unsuitable, but I forget the details.  
> Perhaps he could remind us?

Fixed in the current patch.

> As for this patch: it's a new capability which will get basically zero
> testing for the next year, which is a worry.  How have you tested it, and
> how much?

It's been in RHEL3 for a while now.  First with the
the mistake Andrea identified, but that code's been
fixed too now...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
