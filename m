Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWBCSFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWBCSFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWBCSFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:05:31 -0500
Received: from mail.visionpro.com ([63.91.95.13]:48064 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751242AbWBCSFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:05:30 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Stale NFS File Handle
Date: Fri, 3 Feb 2006 10:05:30 -0800
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0970A93@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stale NFS File Handle
Thread-Index: AcYo7Gs5yqxpa+ehReWCAFGoyFjq2A==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning all (kind of a long winded mail, please have patience!)

I've got an FC3 server running a 2.6.9 kernel and sharing about 500GB of
disk space on a RAID5 array via NFS.  This box has been running fine for
over a year now but in the last three weeks or so I'm seeing a ton of
Stale NFS File Handle errors; especially in my overnight builds.

Most of my clients are FC3 and a couple of Solaris boxes running a stock
configuration.  All we're doing is serving up NFS and compiling with
GCC.  We're seeing this error more and more and the harder I try to
track it down, the more we're seeing it (ok, maybe that's my
imagination).

I'm guessing that the problem has to be somewhere in the FC3 server
because I've still got some Solaris NFS servers that have been running
for years with no problems.

What should I be looking for in tracking this error down?  Should I
upgrade my kernel?  Should I throw away FC3 and go to Enterprise Linux?
I'm at the end of my rope here because this is now causing a major set
back to our development team!

Please help!

-brian

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> Those of you who think you know it all,
  really annoy those of us who do! 

