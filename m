Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759618AbWLFBpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759618AbWLFBpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759491AbWLFBpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:45:53 -0500
Received: from palrel10.hp.com ([156.153.255.245]:58047 "EHLO palrel10.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759481AbWLFBpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:45:51 -0500
Message-Id: <6.2.0.14.2.20061205172536.086fa438@esmail.cup.hp.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.0.14
Date: Tue, 05 Dec 2006 17:27:14 -0800
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Steve Wise" <swise@opengridcomputing.com>
From: Michael Krause <krause@cup.hp.com>
Subject: Re: [openib-general] [PATCH  v2 04/13] Connection Manager
Cc: netdev@vger.kernel.org, "Roland Dreier" <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "Divy Le Ray" <divy@chelsio.com>
In-Reply-To: <20061205180939.GA26384@2ka.mipt.ru>
References: <20061205050725.GA26033@2ka.mipt.ru>
 <1165330925.16087.13.camel@stevo-desktop>
 <20061205151905.GA18275@2ka.mipt.ru>
 <1165333198.16087.53.camel@stevo-desktop>
 <20061205155932.GA32380@2ka.mipt.ru>
 <1165335162.16087.79.camel@stevo-desktop>
 <20061205163008.GA30211@2ka.mipt.ru>
 <1165337245.16087.95.camel@stevo-desktop>
 <20061205172649.GA20229@2ka.mipt.ru>
 <1165341100.16087.109.camel@stevo-desktop>
 <20061205180939.GA26384@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you require more details on how this all works - it was fully explored 
in the IETF RDDP workgroup - may I suggest a reading of the RDMA Security 
Considerations draft which goes through many of the issues on how one 
relates to a host stack.   This complements the MPA spec and supports much 
of what Steve has already responded to during this string of e-mails.  We 
took a great deal of time and debate to insure this can work efficiently 
and without confusion in terms of who owns what and when.

Mike



At 10:09 AM 12/5/2006, Evgeniy Polyakov wrote:
>On Tue, Dec 05, 2006 at 11:51:40AM -0600, Steve Wise 
>(swise@opengridcomputing.com) wrote:
> > > Almost - except the case about where those skbs are coming from?
> > > It looks like they are obtained from network, since it is ethernet
> > > driver, and if they match some set of rules, they are considered as 
> valid
> > > MPA negotiation protocol.
> >
> > They come from the Ethernet driver, but that driver manages multiple HW
> > queues and these packets come from an offload queue, not the NIC queue.
> > So the HW demultiplexes.
>
>Ok, thanks for explaination.
>
>--
>         Evgeniy Polyakov
>
>_______________________________________________
>openib-general mailing list
>openib-general@openib.org
>http://openib.org/mailman/listinfo/openib-general
>
>To unsubscribe, please visit 
>http://openib.org/mailman/listinfo/openib-general


