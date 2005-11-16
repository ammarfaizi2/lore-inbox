Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVKPSDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVKPSDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVKPSDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:03:07 -0500
Received: from waste.org ([64.81.244.121]:58035 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030304AbVKPSDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:03:06 -0500
Date: Wed, 16 Nov 2005 10:01:40 -0800
From: Matt Mackall <mpm@selenic.com>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] misc: Make *[ug]id16 support optional
Message-ID: <20051116180140.GO31287@waste.org>
References: <11.282480653@selenic.com> <200511160721.30845.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511160721.30845.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 07:21:30AM -0600, Rob Landley wrote:
> On Friday 11 November 2005 02:35, Matt Mackall wrote:
> > Configurable 16-bit UID and friends support
> >
> > This allows turning off the legacy 16 bit UID interfaces on embedded
> > platforms.
> 
> Is there an easy way to make sure our programs aren't using these?  (If I 
> build a new system from source with busybox and uclibc, how do I know if I 
> can disable this?)

These should only be found in legacy binaries, ie 5+ years old.

-- 
Mathematics is the supreme nostalgia of our time.
