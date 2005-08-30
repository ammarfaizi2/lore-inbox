Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVH3DqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVH3DqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVH3DqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:46:16 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:48789 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750822AbVH3DqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:46:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Date: Tue, 30 Aug 2005 13:48:59 +1000
User-Agent: KMail/1.8.2
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Thomas Renninger <trenn@suse.de>
References: <1125354385.4598.79.camel@mindpipe> <200508301005.07353.kernel@kolivas.org> <20050830025459.GA16467@thunk.org>
In-Reply-To: <20050830025459.GA16467@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301348.59357.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005 12:54 pm, Theodore Ts'o wrote:
> On Tue, Aug 30, 2005 at 10:05:06AM +1000, Con Kolivas wrote:
> > On Tue, 30 Aug 2005 08:42, Christopher Friesen wrote:
> > > Lee Revell wrote:
> > > > The controversy over the introduction of CONFIG_HZ demonstrated the
> > > > urgency of getting a dynamic tick solution merged before 2.6.14.
> > > >
> > > > Anyone care to give a status report?  Con, do you feel that the last
> > > > version you posted is ready to go in?
> > >
> > > Last time I got interested in this, the management of the event queues
> > > was still a fairly major performance hit.
> > >
> > > Has this overhead been brought down to reasonable levels?
> >
> > Srivatsa is still working on the smp-aware scalable version, so it's back
> > in the development phase.
>
> Has there been an updated version of Thomas's C-state bus-mastering
> measurement patch?

Same issue, it's waiting on dynticks before being reworked.

Cheers,
Con
