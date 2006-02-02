Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWBBJs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWBBJs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBBJs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:48:58 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:58084 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161018AbWBBJs5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:48:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mI7bWFxUN5hIzAfJSSCpvnhoDja9i3DeQLlkywoWjHgCBND+oJMQLDB1x9hpqG3Y/ageOtnhVk6JmEznrdIjx1jnGyHj43B3WXhmMAzeOSSfLbZ7dvoaxxjjCMjYFl6CRY/g2hgSEb0zuJay+Auc8fpzb8ZswVgIXwmqSqb2MQw=
Message-ID: <21d7e9970602020148r52476d7eh32e0d0ed44b598c5@mail.gmail.com>
Date: Thu, 2 Feb 2006 20:48:55 +1100
From: Dave Airlie <airlied@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: R: Xorg crashes 2.6.16-rc1-git4
Cc: Mauro Tassinari <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org,
       airlied@linux.ie
In-Reply-To: <1138740983.22358.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAATCL5fQYOzEifgaWohcVWWwEAAAAA@cmanet.it>
	 <1138740690.22358.11.camel@localhost>
	 <1138740983.22358.15.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-01-31 at 21:34 +0100, Mauro Tassinari wrote:
> > > in both cases, no kernel video module was loaded.
> > > Hope this helps a bit, thank you for your attention.
>
> On Tue, 2006-01-31 at 22:51 +0200, Pekka Enberg wrote:
> > Does disabling CONFIG_DRM_RADEON fix the hard lock? You have compiled
> > Radeon DRM as module so I think X will try to load it at start-up.
>
> Seems likely as others are having problems with RV370 as well:
>
> https://bugs.freedesktop.org/show_bug.cgi?id=5341

Can you disable DRI in xorg.conf? remove the Load "dri" line.

X probably shouldn't enable dri by default on r300..

Dave.
