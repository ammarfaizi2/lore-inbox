Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWFGWA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWFGWA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWFGWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:00:59 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:15030
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932433AbWFGWA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:00:59 -0400
Message-ID: <44874C9A.8040603@microgate.com>
Date: Wed, 07 Jun 2006 17:00:58 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com>	<20060607143138.62855633.rdunlap@xenotime.net>	<4487488F.3010100@microgate.com> <20060607144859.3ae7bb6d.rdunlap@xenotime.net>
In-Reply-To: <20060607144859.3ae7bb6d.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> I just wanted you to see how this is handled in some other places
> in the kernel tree.

That is useful, as I was unaware that comparison operators were
allowed in forming the depends on expression.

If it actually offered the benefit of automatic
promotion/demotion to correct the configuration mismatch,
then I would be all for it.

The limitations of simply disabling generic HDLC support
on mismatch (essentially what Krzysztof suggested) are
not too bad. This would generally only happen on random
kernel configuration tests. If a customer decides to use
that method to configure a kernel, then they get
what they deserve :-) (a chance to bug me for support)

Thanks again,
Paul
