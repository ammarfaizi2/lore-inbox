Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbUCNDrA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 22:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUCNDrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 22:47:00 -0500
Received: from fmr06.intel.com ([134.134.136.7]:35779 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263268AbUCNDq5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 22:46:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: PATCH - InfiniBand Access Layer (IBAL)
Date: Sat, 13 Mar 2004 19:46:12 -0800
Message-ID: <1AC79F16F5C5284499BB9591B33D6F000B630B@orsmsx408.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH - InfiniBand Access Layer (IBAL)
Thread-Index: AcQJbL8jBzws8Yf4TEOWCpznXP8I/QAA6f3A
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Greg KH" <greg@kroah.com>, "Woodruff, Robert J" <woody@jf.intel.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Sam Ravnborg" <sam@ravnborg.org>,
       "Timothy Miller" <miller@techsource.com>,
       "Rik van Riel" <riel@redhat.com>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       <linux-kernel@vger.kernel.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       <marcelo.tosatti@cyclades.com>
X-OriginalArrivalTime: 14 Mar 2004 03:46:13.0485 (UTC) FILETIME=[E58731D0:01C40976]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 02:07:13PM -0800, Greg KH wrote:
>I think you need to work with the openib.org people as they seem to
>have:
>	- working code with support for a number of different devices
I have code that has been running MPI NBPs, Pallas benchmark, and IPoIB
stress tests
for almost 10 days now on multiple vendors equipment. We are also close
to having
a major data base vendor's DAPL stress test running very well.  I'm
thinkin this code could be
running 1000 nodes clusters within a couple of months, if people wanted
to try it,
but that would require Mellanox to open source their TVPD. 
>	- developers with extensive kernel programming experience
As if we don't. 
>	  working on cleaning up the code to fit properly into the
>	  kernel tree.
The comments you have given on IBAL would probably only take a few weeks
to change.
>	- their code showing up in at least one distro which will expose
>	  them to a much wider range of testing than Intel's project so
>	  far has had.
Ok, the OEMS pushed for and got a distro to accept a TTM solution,
that's OK for getting
InfiniBand jumpstarted, 
but does that mean we have to accept it into Linux 
and live with that solution forever. 

I guess I just wish they had started working with us on this open source
project 2 years ago
when we started it, rather than developing a complete stack behind
closed doors and then
releasing it without any input from anyone. Now there are serious issues
that will take a lot 
of work to fix. At least our project was totally open from the 
start and anyone could have provided input at any time. 

Enough said.

I understand your position.  We will submit our code to openib.org. 







