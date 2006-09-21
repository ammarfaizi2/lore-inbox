Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWIUWoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWIUWoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWIUWoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:44:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61114
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751694AbWIUWoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:44:01 -0400
Date: Thu, 21 Sep 2006 15:44:15 -0700 (PDT)
Message-Id: <20060921.154415.116358287.davem@davemloft.net>
To: davej@redhat.com
Cc: jeff@garzik.org, davidsen@tmr.com, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060921220539.GL26683@redhat.com>
References: <45130527.1000302@garzik.org>
	<20060921.145208.26283973.davem@davemloft.net>
	<20060921220539.GL26683@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Thu, 21 Sep 2006 18:05:39 -0400

> On Thu, Sep 21, 2006 at 02:52:08PM -0700, David Miller wrote:
> 
>  > I think the even/odd idea is great, personally.  And if this
>  > makes some people have to wait a little bit longer for their
>  > favorite feature to get merged, that's tough. :-)
> 
> My concern is that people will 'sit out' the even stage, and
> just accumulate stuff in a single tree they dump once when
> every odd release opens up.

At least they would be dumping on top of "mostly working".
I kind of like that.  It breeds more confidence into the
tree having been working before the dump took place, thus
making the isolation of cause much easier.

> We already have some subsystems that do once-per-release merges,
> and then let fixes build up in their out-of-tree SCM for months
> until the next window. It won't necessarily get worse, but unless
> everyone is participating in the odd/even rules, we won't get
> the benefits that it would offer.

Having odd/even rules kind of adds legitimacy to the per-tree folks
doing the same.  This avoids situations like "why is XXX being an
asshole with his tree, when there are other trees merging new
features this round?".  Having buy-in from everyone is very useful
and gets folks in the correct mindset.
