Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUA3QWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUA3QWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:22:40 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:62726 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261262AbUA3QWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:22:38 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpqarray update
Date: Fri, 30 Jan 2004 10:22:32 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E15971@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update
Thread-Index: AcPmp3CJ6/Z2CGCRSWCJjHnZpdBnbgApW9FA
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Greg KH" <greg@kroah.com>, "Hollis Blanchard" <hollisb@us.ibm.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jan 2004 16:22:33.0677 (UTC) FILETIME=[440DF7D0:01C3E74D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. I'll remember that when we update the 2.6 driver (currently the
driver packaged in 2.6.1 is version 2.4.5 ... pretty old).

Thanks
-fw-

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Thursday, January 29, 2004 2:15 PM
> To: Wiran, Francis
> Cc: Greg KH; Hollis Blanchard; Marcelo Tosatti; Linux Kernel 
> Mailing List
> Subject: Re: [PATCH] cpqarray update
> 
> 
> Wiran, Francis wrote:
> > Ok. I'll make a patch when the behaviour changes, as per Greg's:
> > 
> > 
> >>Yeah, I don't really like it either, but figured it was a 
> 2.7 task to
> >>clean it up properly.
> > 
> > 
> > At 2.6.1, it still returns count.
> 
> Look closer:
> 2.4 behavior:  returns count.
> 
> 2.6 behavior:  returns negative value on error, or returns 1 when no
> controllers found, or returns number of controllers found.
> 
> 	Jeff
> 
> 
> 
> 
