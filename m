Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUBXWTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUBXWTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:19:01 -0500
Received: from fmr05.intel.com ([134.134.136.6]:50096 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262462AbUBXWS4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:18:56 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: PATCH - InfiniBand Access Layer (IBAL)
Date: Tue, 24 Feb 2004 14:18:18 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C36CA@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH - InfiniBand Access Layer (IBAL)
Thread-Index: AcP7EIVy3nf5+utOTCWbCdHVm/R0cQADdY3Q
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Greg KH" <greg@kroah.com>, "Christoph Hellwig" <hch@infradead.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       <linux-kernel@vger.kernel.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       <marcelo.tosatti@cyclades.com>, <torvalds@osdl.org>
X-OriginalArrivalTime: 24 Feb 2004 22:18:20.0132 (UTC) FILETIME=[1BDC4240:01C3FB24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 07:50:18PM +0000, Greg KH wrote:

>Please make those changes and then post the patch here 
>(not just a link, if it's too big, split it up into the logical pieces
to fit.)  
> We can go from there.

> You mean this whole huge chunk of code doesn't have any hardware
drivers?  
> What good is it then?

Good to split things into chunks so that it is more manageable for
review
by the Linux community. 

Hardware drivers coming soon.
I saw an email on the InfiniBand sourceforge list 
a couple weeks back that the Mellanox people will be providing open
source code 
for their InfiniBand hardware pretty soon. It may need some rework to
meet the 
standards of the Linux community and fit into the reworked IBAL. I also
saw 
a note from a guy from Fujitsu on the Infiniband list 
that they have a 2.6 hardware driver for IBAL for their HCA, but I am
not 
sure of their open source plans. 
Pretty soon, I don't think people will need worry about a lack of
InfiniBand open 
source code. There may be more of it than you will want to deal with. 

BTW. The patch on sourceforge should be OK now. My error on initial
upload
and now fixed. 
