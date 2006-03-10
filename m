Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWCJPyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWCJPyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWCJPyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:54:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750709AbWCJPyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:54:04 -0500
Date: Fri, 10 Mar 2006 10:53:44 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Roland Dreier <rdreier@cisco.com>,
       rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Message-ID: <20060310155344.GA15214@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	Bryan O'Sullivan <bos@pathscale.com>,
	Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain> <adapskvfbqe.fsf@cisco.com> <1141947143.10693.40.camel@serpentine.pathscale.com> <20060310003513.GA17050@suse.de> <1141951589.10693.84.camel@serpentine.pathscale.com> <20060310010050.GA9945@suse.de> <1141966693.14517.20.camel@camp4.serpentine.com> <20060310063401.GA30968@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310063401.GA30968@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 10:34:01PM -0800, Greg KH wrote:
 > On Thu, Mar 09, 2006 at 08:58:13PM -0800, Bryan O'Sullivan wrote:
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
 > > Hat or SUSE).
 > 
 > Well, I can do something about SuSE, it's up to someone else to persuade
 > Red Hat :)

It's been built into Fedora kernels since it was merged upstream.
It isn't in RHEL4, as it wasn't around back in 2.6.9, and unless there's
a really compelling argument for it, I doubt it'll be backported.

		Dave

-- 
http://www.codemonkey.org.uk
