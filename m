Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVCCWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVCCWCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVCCV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:59:11 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:24157 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S262627AbVCCV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:56:55 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="3.90,134,1107734400"; 
   d="scan'208"; a="231178974:sNHT8294257804"
Message-Id: <200503032156.AWY71165@mira-sjc5-e.cisco.com>
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Greg KH'" <greg@kroah.com>,
       "'David S. Miller'" <davem@davemloft.net>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: RFD: Kernel release numbering
Date: Thu, 3 Mar 2005 13:56:46 -0800
Organization: Cisco Systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <Pine.LNX.4.58.0503031101270.25732@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Thread-Index: AcUgJTvag6mVIkQ6Rqi5gVVETxflRgAFYjHg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In other words, I'm really talking about something different 
> from what you seem to envision. 

Indeed. What I have in mind (and suggested in the past) is that we have a
real 2.6 stable release maintainer. The only difference is that he starts
from a random 2.6.x release he picks, and releases 2.6.x.y until he thinks
stable enough, and he moves on to another 2.6.z release and start the same
work. He decides which 2.6.x to pick for the next stable release. Alan Cox
has expressed his interest in this during the last discussion but it seems
you didn't pay attention or care.

The reason that I think it's important for some other person to do this job
independently is that you are not bothered by bugfixes, which you never did
well. :) You move on to each release as you do today, with different
criteria, and someone else who can do the job better do so to stablize it.

In the end it's more like the old way of 2.5/2.4, but just with a shorter
release cycle, and the "2.6 stable release maintainer" could also continue
to pick up new 2.6.x releases to work on instead of having to be stuck on
one tree for 2 years or ever. He can say "this is the last 2.6.12.x release
and next I'll start 2.6.16.1", etc.

For this to happen the person has to be well-recognized and trusted by the
community. Alan is one of the best candidates. :) Of course, I'm not sure if
he is still interested..

Hua
