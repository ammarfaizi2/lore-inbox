Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbUCMWIH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbUCMWIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:08:06 -0500
Received: from fmr05.intel.com ([134.134.136.6]:39346 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263197AbUCMWIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:08:02 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: PATCH - InfiniBand Access Layer (IBAL)
Date: Sat, 13 Mar 2004 14:07:13 -0800
Message-ID: <1AC79F16F5C5284499BB9591B33D6F000B6306@orsmsx408.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH - InfiniBand Access Layer (IBAL)
Thread-Index: AcP70lxuHEOyryetSJCB/w9i3aXcfwNb22bg
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Sam Ravnborg" <sam@ravnborg.org>,
       "Greg KH" <greg@kroah.com>
Cc: "Timothy Miller" <miller@techsource.com>, "Rik van Riel" <riel@redhat.com>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       <linux-kernel@vger.kernel.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       <marcelo.tosatti@cyclades.com>
X-OriginalArrivalTime: 13 Mar 2004 22:07:14.0186 (UTC) FILETIME=[8A5C76A0:01C40947]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Linus Torvalds wrote:

>Oh, I agree that _reviewing_ code is good, together with feedback 
>on what would improve its chances of getting accepted later on. 
>But it should be clear that regardless, 
>we don't add features that nobody 
>can sanely test and where hardware isn't available.
>
>		Linus

Just wanted to give an update on where we are with the InfiniBand IBAL.

After we submitted the IBAL code for review, there has been additional
InfiniBand code put into open source by the major InfiniBand companies,
namely TopSpin, Mellanox, InfiniCon, and Voltaire.
This presents somewhat of a problem because now there are multiple 
versions of the various InfiniBand S/W components, Access Layers, and
ULPs.

We now need to review all this code and
determine which code is best to use as a basis for something that 
we would eventually try to get into Linux. We hope that people in the
linux community will help us sort through this mess and come up with
a "best of breed" stack out of all the available code. 

The Mellanox and Topspin folks along with some people from some of
the national labs are trying to start up a website called openib.org,
with data bases, email lists, etc. where people can submit code for
this "best of breed" stack and discuss it. As long as it is truly 
open, the linux community is allowed to participate, and the code
is evaluated on it's technical merits, rather than one companies
personal
agenda, this forum might serve as a way for us to sort through this
without
taking every issue to lkml. 

What are your thoughts on how we should proceed ? 






