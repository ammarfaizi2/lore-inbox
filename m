Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVHVWRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVHVWRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVHVWRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:17:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17822 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751322AbVHVWRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:17:42 -0400
Date: Mon, 22 Aug 2005 17:17:35 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] external interrupts
In-Reply-To: <20050822144330.791ba7b3.akpm@osdl.org>
Message-ID: <20050822165125.W325@chenjesu.americas.sgi.com>
References: <20050819160716.U87000@chenjesu.americas.sgi.com>
 <20050820222159.GP516@openzaurus.ucw.cz> <20050822155852.N325@chenjesu.americas.sgi.com>
 <20050822144330.791ba7b3.akpm@osdl.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2005, Andrew Morton wrote:

> Having an abstraction layer for a single client driver does seem a bit
> pointless.  It would become more pointful if other client drivers were to
> pop up.
>
> Hence an option would be to merge an IOC4-specific driver which just does
> what you need, no abstraction layer.  If someone later comes up with a
> requirement for a driver for similar-looking hardware then we can resurrect
> the abstraction layer at that stage.

Agreed.  I'll look into what our plans are for additional or follow-on
devices.  Right now I see a need for this on the horizon, but it's not
much more than a tiny indistiguishable dot.  I'll have more info in a
day or two.  I'll also use that time to fix up the things that
Christoph Hellwig noticed.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
