Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263163AbTC1WDf>; Fri, 28 Mar 2003 17:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbTC1WDf>; Fri, 28 Mar 2003 17:03:35 -0500
Received: from havoc.daloft.com ([64.213.145.173]:38312 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S263163AbTC1WDe>;
	Fri, 28 Mar 2003 17:03:34 -0500
Date: Fri, 28 Mar 2003 17:14:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com
Subject: Re: NICs trading places ?
Message-ID: <20030328221446.GA1549@gtf.org>
References: <20030328221037.GB25846@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328221037.GB25846@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 10:10:37PM +0000, Dave Jones wrote:
> I just upgraded a box with 2 NICs in it to 2.5.66, and found
> that what was eth0 in 2.4 is now eth1, and vice versa.
> Is this phenomenon intentional ? documented ?
> What caused it to do this ?

That's a bug that no one has tracked down yet.

Jamal reported it, too.

ethX numbering shouldn't be changing without a good reason...

	Jeff



