Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVKJRUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVKJRUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVKJRUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:20:10 -0500
Received: from fmr23.intel.com ([143.183.121.15]:17293 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751174AbVKJRUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:20:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: merge status 
Date: Thu, 10 Nov 2005 09:17:46 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04EAE53D@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: merge status 
Thread-Index: AcXlz7JawvUyye1dTTSdq00AHdDN0QAR8I4A
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Ben Collins" <bcollins@debian.org>,
       "Jody McIntyre" <scjody@modernduck.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Roland Dreier" <rolandd@cisco.com>,
       "Dave Jones" <davej@codemonkey.org.uk>, "Jens Axboe" <axboe@suse.de>,
       "Dave Kleikamp" <shaggy@austin.ibm.com>,
       "Steven French" <sfrench@us.ibm.com>, "Keith Owens" <kaos@ocs.com.au>
X-OriginalArrivalTime: 10 Nov 2005 17:17:47.0487 (UTC) FILETIME=[ABBEBEF0:01C5E61A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Is Tony's strategy described anywhere?
>
>Tony's mail.

There have been a couple of updates to the doc since
then to keep pace with changes in GIT.  The latest
is in the GIT sources in:

 Documentation/howto/using-topic-branches.txt

[or just click on http://tinyurl.com/bzll2]

It sounds like our approaches are very similar, just some
differences in terminology (you say "theme branch"
where I say "topic branch" etc.).  Plus perhaps some
variations in usage.  Almost all of my topic branches
only ever see one commit (or one series of commits if
the patch was supplied as a series of patches).  Plus
I haven't exported topic branches, mostly because I don't
often see people building on them[1].  But there are always
exceptions to any rule, so I did have a "swiotlb" branch
during this last pass to keep track of the move of
swiotlb.c out of arch/ia64/lib/ and into lib/.

So a review of the note I contributed to the GIT documents
would be helpful ... especially if you have any nifty
scripts that you use to manage things that you feel like
sharing.

-Tony

[1] But perhaps beacuse I don't what Linus to think I have
an oversize head: http://tinyurl.com/c3z53 :-)



