Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVBII4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVBII4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 03:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVBII4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 03:56:01 -0500
Received: from orb.pobox.com ([207.8.226.5]:12958 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261739AbVBIIz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 03:55:56 -0500
Date: Wed, 9 Feb 2005 00:55:51 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
Message-ID: <20050209085551.GB7524@ip68-4-98-123.oc.oc.cox.net>
References: <20050204103350.241a907a.akpm@osdl.org> <Pine.LNX.4.61.0502090357060.7433@student.dei.uc.pt> <20050208205406.7e262b07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208205406.7e262b07.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 08:54:06PM -0800, Andrew Morton wrote:
> "Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
> >
> > Please add to -mm the patch in attachment, since it solves the old
> >  acpi_power_off bug...
> 
> What acpi_power_off bug?  And how does it solve it?

Here's the observed bug that the patch is trying to fix:
http://bugme.osdl.org/show_bug.cgi?id=4041

What Marcos posted is a typo-corrected version of Eric Biederman's
patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110665542929525&w=2

In Eric's own words, the patch "needs some work before it goes into a
mainline kernel". AFAICT it's more of a proof-of-concept, just to see if
Eric's on the right track...

This is the motivation behind the patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110665405402747&w=2

-Barry K. Nathan <barryn@pobox.com>

