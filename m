Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUCSTZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUCSTZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:25:55 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:32192 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S263164AbUCSTXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:23:49 -0500
From: "Fab Tillier" <ftillier@infiniconsys.com>
To: "'Ulrich Drepper'" <drepper@redhat.com>,
       "Woodruff, Robert J" <woody@co.intel.com>
Cc: "Woodruff, Robert J" <woody@jf.intel.com>, <linux-kernel@vger.kernel.org>,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
Subject: RE: PATCH - InfiniBand Access Layer (IBAL)
Date: Fri, 19 Mar 2004 11:21:15 -0800
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A7A@mercury.infiniconsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <405B403F.4000702@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-OriginalArrivalTime: 19 Mar 2004 19:23:48.0813 (UTC) FILETIME=[B461C7D0:01C40DE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ulrich Drepper [mailto:drepper@redhat.com]
> Sent: Friday, March 19, 2004 10:47 AM
> 
> So, these people come up with their own software stacks, unreviewed
> interface extensions, and demand that everybody accepts what they were
> "designing" without the ability to question anything.

Yes, a design review with a period to provide feedback at the design level,
not the code level, would make sense.  I don't see how one could argue
against that.

> 
> I surely find this completely  unacceptable and any consideration of
> accepting anything the Infiniband group comes up with should be
> postponed until every bit of the design can be reviewed.  If bits and
> pieces are accepted prematurely it'll just be "now that this is support
> you have to add this too, otherwise it'll not be useful".

For the IBAL stack, there are numerous documents on the Linux InfiniBand
Project (http://infiniband.sourceforge.net/) describing most everything from
the overall architecture to the APIs.  On the project home page is a general
overview of what InfiniBand is, and how it fits into the OS.  More detailed
documentation is available there too.  Of particular interest to this thread
would be the Access Layer documents. Below are links to documents of
interest.

- The overall software architecture spec is the "Linux SAS", available at
http://infiniband.sourceforge.net/LinuxSAS.1.0.1.pdf.
- A presentation describing the IBAL APIs is here:
http://infiniband.sourceforge.net/IAL/Access/AlInterface.pdf
- The IBAL high level design is here:
http://infiniband.sourceforge.net/IAL/Access/IBA_AL_HLD.pdf
- A user's guide to IBAL is here:
http://infiniband.sourceforge.net/IAL/Access/AL_Users_Guide.pdf
- And finally, the API documentation is here:
http://infiniband.sourceforge.net/IAL/Access/IBAL/IBAL_mi.html

HTH,

- Fab

