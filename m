Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWCJPOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWCJPOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWCJPOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:14:44 -0500
Received: from mailgw.voltaire.com ([193.47.165.252]:1465 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP
	id S1751561AbWCJPOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:14:44 -0500
Subject: Re: [openib-general] Re: [PATCH 8 of 20] ipath - sysfs support for
	core driver
From: Hal Rosenstock <halr@voltaire.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
In-Reply-To: <adairqmbb24.fsf@cisco.com>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com>
	 <20060310011106.GD9945@suse.de>
	 <1141967377.14517.32.camel@camp4.serpentine.com>
	 <20060310063724.GB30968@suse.de>  <adairqmbb24.fsf@cisco.com>
Content-Type: text/plain
Organization: 
Message-Id: <1142003287.4331.28584.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 Mar 2006 10:08:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 09:59, Roland Dreier wrote:
>     Greg> The main issue is that if you create a sysfs file like this,
>     Greg> and then in 3 months realize that you need to change one of
>     Greg> those characters to be something else, you are in big
>     Greg> trouble...
> 
> I think that PortInfo and NodeInfo might be fair game for sysfs files,
> because they are actually defined in the IB spec with a binary format
> that is sent on the wire.  So they're not going to change.

Not true; There have been and likely will be more upward compatible
changes (especially to PortInfo).

-- Hal

> 
> On the other hand it's not clear to me why using that wire protocol as
> an interface to userspace is a good idea...
> 
>  - R.
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
> 
> To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general

