Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272997AbTHSSQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272603AbTHSR7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:59:52 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:27060 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S272456AbTHSRqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:46:39 -0400
Date: Wed, 20 Aug 2003 03:46:00 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/10] 2.6.0-t3: struct C99 initialiser conversion
Message-ID: <20030819174600.GW643@zip.com.au>
References: <20030819063727.GL643@zip.com.au> <20030819172355.GA4864@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819172355.GA4864@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 10:23:55AM -0700, Greg KH wrote:
> On Tue, Aug 19, 2003 at 04:37:27PM +1000, CaT wrote:
> > @@ -329,7 +329,7 @@
> >  	switch (bmRType_bReq) {
> >  		/* Request Destination:
> >  		   without flags: Device, 
> > -		   RH_INTERFACE: interface, 
> > +		   RH_INTERFACE: interface,
> >  		   RH_ENDPOINT: endpoint,
> >  		   RH_CLASS means HUB here, 
> >  		   RH_OTHER | RH_CLASS  almost ever means HUB_PORT here 
> 
> I think you need to work on your scripts if you thought this was a C99
> "fix".  More like a "delete trailing space" patch...

That it is. I was aware of it but I didn't think leaving it there would
hurt... But I'll take it out of the -bk6 patch.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
