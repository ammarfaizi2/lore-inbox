Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWCJPz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWCJPz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWCJPz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:55:28 -0500
Received: from mx.pathscale.com ([64.160.42.68]:37072 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751669AbWCJPz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:55:27 -0500
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20]
	ipath - sysfs support for core driver)
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, Roland Dreier <rdreier@cisco.com>,
       rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1141999569.2876.47.camel@laptopd505.fenrus.org>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
	 <adapskvfbqe.fsf@cisco.com>
	 <1141947143.10693.40.camel@serpentine.pathscale.com>
	 <20060310003513.GA17050@suse.de>
	 <1141951589.10693.84.camel@serpentine.pathscale.com>
	 <20060310010050.GA9945@suse.de>
	 <1141966693.14517.20.camel@camp4.serpentine.com>
	 <1141977431.2876.18.camel@laptopd505.fenrus.org>
	 <1141998702.28926.15.camel@localhost.localdomain>
	 <1141999569.2876.47.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 07:55:21 -0800
Message-Id: <1142006121.29925.5.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 15:06 +0100, Arjan van de Ven wrote:

> > They mightn't be exactly today's kernels, but they're no more than two
> > or three weeks old.  CONFIG_DEBUG_FS has been in the kernel for a long
> > time, and it's still not being picked up.
> 
> but it's a module; you can ship it no problem yourself if you go through
> the hell of shipping external modules

Yes, we can ship it ourselves.  But a significant point of this exercise
is to have the drivers be available to people who use unmodified
distros, and don't want to download other bits to do so.

If Greg can get SUSE to turn on debugfs, that's great.  I can ask Dave
Jones or Doug Ledford or some other Fedora/RedHat kernel person to do
likewise, but they're not beholden to me in any way, so god knows what
my chances are :-)

The "have it just work in vendor distros" notion is also why the OpenIB
community as a whole is focusing on rolling out a 1.0 release of the IB
userspace code, so that people can expect their distros to simply work
with Infiniband hardware.

	<b

