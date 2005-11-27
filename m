Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVK0R1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVK0R1g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 12:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVK0R1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 12:27:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:46468 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751125AbVK0R1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 12:27:35 -0500
Date: Sun, 27 Nov 2005 18:27:25 +0100
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, paulmck@us.ibm.com, greg@kroah.com,
       Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <20051127172725.GJ20775@brahms.suse.de>
References: <20051127134735.GK31722@brahms.suse.de> <22267.1133107145@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22267.1133107145@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 02:59:05AM +1100, Keith Owens wrote:
> On Sun, 27 Nov 2005 14:47:36 +0100, 
> Andi Kleen <ak@suse.de> wrote:
> >akpm wrote
> >>   - Introduce a new notifier API which is wholly unlocked
> >
> >The old notifiers were already wholly unlocked. So it wouldn't 
> >even need any changes. Just additional locks everywhere.
> 
> Wrong.  

Did you actually read what I wrote? 

-Andi
