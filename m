Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWCZQns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWCZQns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWCZQns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:43:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45499 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751478AbWCZQnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:43:47 -0500
Date: Sun, 26 Mar 2006 22:10:59 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink interface for delay accounting
Message-ID: <20060326164059.GB13362@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060323154106.GA13159@in.ibm.com> <1143209061.5076.14.camel@jzny2> <20060324145459.GA7495@in.ibm.com> <1143249565.5184.6.camel@jzny2> <20060325094126.GA9376@in.ibm.com> <1143291133.5184.32.camel@jzny2> <20060325153632.GA25431@in.ibm.com> <1143308901.5184.48.camel@jzny2> <661de9470603251022w7f8991e9g73d70a65f5d475ea@mail.gmail.com> <1143381918.5184.52.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143381918.5184.52.camel@jzny2>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 09:05:18AM -0500, jamal wrote:
> On Sat, 2006-25-03 at 23:52 +0530, Balbir Singh wrote:
> 
> 
> > No, we cannot have both passed. If we pass both a PID and a TGID and
> > then the code returns just the stats for the PID.
> > 
> 
> ok, that clears it then; i think you are ready to go.

Cool! Thanks for all your help and review.

> 
> > >
> > > Also in regards to the nesting, isnt there a need for nla_nest_cancel in
> > > case of failures to add TLVs?
> > >
> > 
> > I thought about it, but when I looked at the code of genlmsg_cancel()
> > and nla_nest_cancel().  It seemed that genlmsg_cancel() should
> > suffice.
> > 
> 
> If your policy is to never send a message if anything fails, then you
> are fine.
> 
> What would be really useful now that you understand this, is if you can
> help extending/cleaning the document i sent you. Or send me a table of
> contents of how it would have flowed better for you.

I will start looking at the document and see what changes can be made.
I will try and update the document from a genetlink programmers perspective
i.e. things to know, avoid, etc.

> 
> cheers,
> jamal
> 
>

Thanks,
Balbir 
