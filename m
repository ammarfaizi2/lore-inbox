Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSGYR6F>; Thu, 25 Jul 2002 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSGYR6F>; Thu, 25 Jul 2002 13:58:05 -0400
Received: from ns.suse.de ([213.95.15.193]:61451 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316605AbSGYR6E>;
	Thu, 25 Jul 2002 13:58:04 -0400
Date: Thu, 25 Jul 2002 20:01:18 +0200
From: Dave Jones <davej@suse.de>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: MTRR Problems - 2.4.19-rc3
Message-ID: <20020725200117.C8672@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
	rgooch@atnf.csiro.au
References: <200207250303.20809.spstarr@sh0n.net> <200207251341.24933.spstarr@sh0n.net> <20020725195000.A8672@suse.de> <200207251355.59880.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207251355.59880.spstarr@sh0n.net>; from spstarr@sh0n.net on Thu, Jul 25, 2002 at 01:55:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 01:55:59PM -0400, Shawn Starr wrote:

(Please learn to quote correctly)

 > > Something in userspace tried to delete an MTRR that didn't exist.
 > > The only time I've seen this happen personally has been with
 > > a dual-head card for which the BIOS set up one MTRR to cover
 > > the video ram used by both heads, and then iirc X did something
 > > silly and tried to remove separate MTRRs for each head on exit.
 >
 > Is there a fix to this?

Don't know, I didn't have the card that showed that behaviour long,
and my current dual head cards don't exhibit it, so either it got fixed
in a newer X, or its driver specific.

Either way, it's a userspace problem afaics.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
