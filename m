Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVH3CzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVH3CzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 22:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVH3CzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 22:55:04 -0400
Received: from thunk.org ([69.25.196.29]:27276 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932097AbVH3CzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 22:55:02 -0400
Date: Mon, 29 Aug 2005 22:54:59 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050830025459.GA16467@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Con Kolivas <kernel@kolivas.org>,
	Christopher Friesen <cfriesen@nortel.com>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Srivatsa Vaddagiri <vatsa@in.ibm.com>,
	Thomas Renninger <trenn@suse.de>
References: <1125354385.4598.79.camel@mindpipe> <43138F3B.7010704@nortel.com> <200508301005.07353.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508301005.07353.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:05:06AM +1000, Con Kolivas wrote:
> On Tue, 30 Aug 2005 08:42, Christopher Friesen wrote:
> > Lee Revell wrote:
> > > The controversy over the introduction of CONFIG_HZ demonstrated the
> > > urgency of getting a dynamic tick solution merged before 2.6.14.
> > >
> > > Anyone care to give a status report?  Con, do you feel that the last
> > > version you posted is ready to go in?
> >
> > Last time I got interested in this, the management of the event queues
> > was still a fairly major performance hit.
> >
> > Has this overhead been brought down to reasonable levels?
> 
> Srivatsa is still working on the smp-aware scalable version, so it's back in 
> the development phase.

Has there been an updated version of Thomas's C-state bus-mastering
measurement patch?

					- Ted

