Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWCJNvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCJNvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWCJNvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:51:17 -0500
Received: from mx.pathscale.com ([64.160.42.68]:45767 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751101AbWCJNvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:51:16 -0500
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20]
	ipath - sysfs support for core driver)
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, Roland Dreier <rdreier@cisco.com>,
       rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1141977431.2876.18.camel@laptopd505.fenrus.org>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
	 <adapskvfbqe.fsf@cisco.com>
	 <1141947143.10693.40.camel@serpentine.pathscale.com>
	 <20060310003513.GA17050@suse.de>
	 <1141951589.10693.84.camel@serpentine.pathscale.com>
	 <20060310010050.GA9945@suse.de>
	 <1141966693.14517.20.camel@camp4.serpentine.com>
	 <1141977431.2876.18.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 05:51:41 -0800
Message-Id: <1141998702.28926.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 08:57 +0100, Arjan van de Ven wrote:
> On Thu, 2006-03-09 at 20:58 -0800, Bryan O'Sullivan wrote:
> > On Thu, 2006-03-09 at 17:00 -0800, Greg KH wrote:
> > 
> > > They are in the latest -mm tree if you wish to use them.  Unfortunatly
> > > it might look like they will not work out, due to the per-cpu relay
> > > files not working properly with Paul's patches at the moment.
> > 
> > Hmm, OK.
> > 
> > > What's wrong with debugfs?
> > 
> > It's not configured into the kernels of either of the distros I use (Red
> > Hat or SUSE).  I can't have a required part of my driver depend on a
> > feature that's not enabled in the major distro kernels.
> 
> sucks to be you, however I think it's equally or even more unacceptable
> to cripple the main kernel because you want to also support antique
> kernels (those more than 12 months old).

What antique kernels?  It's not enabled in the latest SLES beta
(2.6.16-git6 or so), or in Fedora rawhide (also 2.6.16-git).

They mightn't be exactly today's kernels, but they're no more than two
or three weeks old.  CONFIG_DEBUG_FS has been in the kernel for a long
time, and it's still not being picked up.

>  The general rule is "if you
> want to support that, do it outside the kernel.org tree".

Which "that" are you referring to?

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

