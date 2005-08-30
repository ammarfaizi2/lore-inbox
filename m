Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVH3RMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVH3RMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVH3RMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:12:30 -0400
Received: from fmr18.intel.com ([134.134.136.17]:9612 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932213AbVH3RM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:12:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: KLive: Linux Kernel Live Usage Monitor
Date: Tue, 30 Aug 2005 10:08:38 -0700
Message-ID: <194B303F2F7B534594F2AB2D87269D9F06EFAE48@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KLive: Linux Kernel Live Usage Monitor
Thread-Index: AcWtfn2YvGZltHF2S9egjSlByW0jRAABE3OA
From: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Aug 2005 17:08:39.0894 (UTC) FILETIME=[779CAF60:01C5AD85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Aug 30, 2005 at 10:01:21AM +0200, Sven Ladegast wrote:
> The idea isn't bad but lots of people could think that this is some
kind 
> of home-phoning or spy software. I guess lots of people would turn
this 
> feature off...and of course you can't enable it by default. But
combined 
> with an automatic oops/panic/bug-report this would be _very_ useful I 
> think.

I think this is useful and would personally participate if it were a
config tweak.  There are a couple of issues that come to mind.  

1. Possibly paranoia, but given the apparent numbers of people with
malicious intent on the Internet and knowing that there are some
financially motivated to make Linux kernel developers over confident in
they're work, I'm not sure I'd trust or use the data unless it was
somehow authenticated.  

2. Some of us sit behind corporate firewalls and proxies that have
oppressive rules that would have made Stalin proud.  The solution must
be proxy aware and if it used HTTP, even better because it's more likely
to work anywhere.  The proxy settings could also be a .config thing.  

3. Again security; I haven't cleared this with my corporate superiors
but I'm not sure they'll like the fact that anyone could intercept the
data and compute how many people in the company are running Linux test
kernels.  I know this almost sounds anti-open but we're breaking them in
slowly to the model and I don't think they are ready for this one just
yet. :)

-bryan
