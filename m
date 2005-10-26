Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVJZUkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVJZUkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVJZUkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:40:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41109 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964906AbVJZUkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:40:05 -0400
Date: Wed, 26 Oct 2005 16:40:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andreas Kleen <ak@suse.de>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@ocs.com.au>,
       <dipankar@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <3941240.1130353524290.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Message-ID: <Pine.LNX.4.44L0.0510261636580.7186-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Andreas Kleen wrote:

> > Note that the RCU documentation says RCU critical sections are not
> > allowed
> > to sleep.
> 
> In this case it would be ok.

I don't understand.  If it's okay for an RCU critical section to sleep in 
this case, why wouldn't it be okay always?  What's special here?

Aren't there requirements about critical sections finishing on the same 
CPU as they started on?

Can you please explain in more detail?

Alan Stern

