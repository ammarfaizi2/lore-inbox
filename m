Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUHOHNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUHOHNa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 03:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUHOHNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 03:13:30 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:1077 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266514AbUHOHN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 03:13:28 -0400
Date: Sun, 15 Aug 2004 09:15:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] don't delete debian directory in official debian builds
Message-ID: <20040815071559.GB7182@mars.ravnborg.org>
Mail-Followup-To: Andres Salomon <dilinger@voxel.net>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1092512343.3971.23.camel@spiral.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092512343.3971.23.camel@spiral.internal>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 03:39:03PM -0400, Andres Salomon wrote:
> Hi,
> 
> Somewhere along the 2.6 series, there was a change made that causes
> distclean to automatically delete the debian/ subdirectory from the top
> of the kernel tree.  This causes grief for the official debian kernel
> packages; the debian directory shouldn't be deleted in the packages.
> Please apply the attached patch; it causes the debian/ subdirectory to
> only be deleted if there's no debian/official.
> 
> An even better solution would be to mark the debian directory as being
> created by the kernel (touch debian/linus), and only delete it if the
> kernel created it.

Such special cases are not acceptable.

If this causes a problem then there are the following options:
1) Rename directory in debian or the kernel
2) Debian apply a patch to the kernel

Preference to 1).

Comments?

	Sam
