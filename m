Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWGSENA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWGSENA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 00:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWGSENA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 00:13:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17888
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932427AbWGSEM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 00:12:59 -0400
Date: Tue, 18 Jul 2006 21:13:22 -0700 (PDT)
Message-Id: <20060718.211322.41951011.davem@davemloft.net>
To: linville@tuxdriver.com
Cc: takis@lumumba.uhasselt.be, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, nico@cam.org, patrick@tykepenguin.com
Subject: Re: [PATCH] Conversions from kmalloc+memset to k(z|c)alloc.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060719024805.GB3786@tuxdriver.com>
References: <20060719011540.GD30823@lumumba.uhasselt.be>
	<20060719024805.GB3786@tuxdriver.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Tue, 18 Jul 2006 22:48:05 -0400

> On Wed, Jul 19, 2006 at 03:15:40AM +0200, Panagiotis Issaris wrote:
> > From: Panagiotis Issaris <takis@issaris.org>
> > 
> > Conversions from kmalloc+memset to k(z|c)alloc.  The original memsets
> > did not clear out the entire allocated structure. To my unexperienced
> > eye, that seemed a bit fishy (or at least a bit weird and inconsistent).
> > 
> > Signed-off-by: Panagiotis Issaris <takis@issaris.org>
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Also applied, thanks a lot.
