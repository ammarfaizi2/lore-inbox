Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUDGWJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUDGWJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:09:32 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:35643 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261184AbUDGWJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:09:29 -0400
Date: Wed, 7 Apr 2004 17:09:28 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407220928.GI2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org> <20040407220224.GA26850@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407220224.GA26850@sgi.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 05:02:24PM -0500, Nathan Straz wrote:
> On Tue, Apr 06, 2004 at 05:03:58PM -0500, Andy Isaacson wrote:
> > Linux-kernel:  is this patch horribly wrong?
> ...
> > to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
> > enable this usage.
> 
> Adding the functionality to conv= doesn't seem right to me.  conv= is
> for converting the data in some way.  This is just changing the way data
> is written.  Right?

There's already conv=notrunc which means "open without O_TRUNC".  I
agree that it's a nonintuitive interface, but then, the entire dd(1)
command line is.

> Have you looked at lmdd?  It supports O_DIRECT and many other things not
> in the standard dd.

Wasn't aware of that one.  Thanks for the pointer.

-andy
