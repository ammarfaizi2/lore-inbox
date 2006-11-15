Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWKOTjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWKOTjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWKOTjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:39:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:3516 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161177AbWKOTjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:39:09 -0500
Subject: Re: [Madwifi-devel] ANNOUNCE: SFLC helps developers assess ar5k
	(enabling free Atheros HAL)
From: Pavel Roskin <proski@gnu.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, madwifi-devel@lists.sourceforge.net,
       lwn@lwn.net
In-Reply-To: <20061115192054.GA10009@tuxdriver.com>
References: <20061115031025.GH3451@tuxdriver.com>
	 <200611151942.14596.mb@bu3sch.de>  <20061115192054.GA10009@tuxdriver.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Nov 2006 14:39:01 -0500
Message-Id: <1163619541.19111.6.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 2006-11-15 at 14:21 -0500, John W. Linville wrote:
> On Wed, Nov 15, 2006 at 07:42:14PM +0100, Michael Buesch wrote:
> 
> > Now that it seems to be ok to use these openbsd sources, should I port
> > them to my driver framework?
> > I looked over the ar5k code and, well, I don't like it. ;)
> > I don't really like having a HAL. I'd rather prefer a "real" driver
> > without that HAL obfuscation.
> 
> I don't think anyone likes the HAL-based architecture.  I don't think
> we will accept a HAL-based driver into the upstream kernel.

I said it before, and it's worth repeating.  Dissolving HAL in the
sources is easy.  It's just a matter of moving functions around without
serious chances of breaking anything as long as the source compiles.
The whole "HAL-based architecture" can be reshuffled and eliminated by
one person in a few days.

Making things work properly takes years.  That's what MadWifi has been
working on for a long time, using contributions and bug reports from
scores of users and developers.

Rejecting MadWifi because it's HAL based is like throwing away a diamond
ring because it's too narrow.

-- 
Regards,
Pavel Roskin


