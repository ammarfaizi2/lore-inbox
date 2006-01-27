Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWA0Xhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWA0Xhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWA0Xhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:37:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422695AbWA0Xhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:37:39 -0500
Subject: Re: iommu_alloc failure and panic
From: Mark Haverkamp <markh@osdl.org>
To: Olof Johansson <olof@lixom.net>
Cc: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060127233443.GB26653@pb15.lixom.net>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net>
	 <20060127204022.GA26653@pb15.lixom.net>
	 <1138401590.11796.26.camel@markh3.pdx.osdl.net>
	 <20060127233443.GB26653@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 15:37:34 -0800
Message-Id: <1138405054.11796.27.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 12:34 +1300, Olof Johansson wrote:
> On Fri, Jan 27, 2006 at 02:39:50PM -0800, Mark Haverkamp wrote:
> 
> > I would have thought that the npages would be 1 now.
> 
> No, npages is the size of the allocation coming from the driver, that
> won't chance. The table blocksize just says how wide the cacheline size
> is, i.e. how far it should advance between allocations.
> 
> This is a patch that should probably have been added a while ago, to
> give a bit more info. Can you apply it and give it a go?

OK, I'll try it and let you know.

Thanks,
Mark.
-- 
Mark Haverkamp <markh@osdl.org>

