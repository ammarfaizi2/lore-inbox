Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751965AbWCIX3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWCIX3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWCIX3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:29:42 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37352
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751965AbWCIX3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:29:41 -0500
Date: Thu, 09 Mar 2006 15:29:34 -0800 (PST)
Message-Id: <20060309.152934.99760924.davem@davemloft.net>
To: dim@openvz.org
Cc: arnd@arndb.de, akpm@osdl.org, dev@openvz.org,
       netfilter-devel@lists.netfilter.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: {get|set}sockopt compat layer
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603091324.00362.dim@openvz.org>
References: <200603071707.19138.dim@openvz.org>
	<200603071605.39177.arnd@arndb.de>
	<200603091324.00362.dim@openvz.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Mishin <dim@openvz.org>
Date: Thu, 9 Mar 2006 13:23:59 +0300

> Hello, Arnd!
> 
> > For the compat_ioctl stuff, we don't have the function pointer inside an
> > #ifdef, the overhead is relatively small since there is only one of these
> > structures per module implementing a protocol, but it avoids having to
> > rebuild everything when changing CONFIG_COMPAT.
> >
> > It's probably not a big issue either way, maybe davem has a stronger
> > opinion on it either way.
> >
> Done.

I think this looks fine but it doesn't apply cleanly to the
current net-2.6.17 tree.

Could you cook up a fresh patch, and send it with a complete
changelog entry and appropriate Signed-off-by: lines?

Thanks a lot Dmitry.
