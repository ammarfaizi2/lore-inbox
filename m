Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932830AbWAIG2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWAIG2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWAIG2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:28:05 -0500
Received: from fmr14.intel.com ([192.55.52.68]:52610 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932822AbWAIG2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:28:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 01:27:19 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A136F6@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUk6Mh9JdutZnVRsiBZXyxSTyMBwAUHl0A
From: "Brown, Len" <len.brown@intel.com>
To: "David S. Miller" <davem@davemloft.net>, <torvalds@osdl.org>
Cc: <martin.langhoff@gmail.com>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <git@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2006 06:27:22.0938 (UTC) FILETIME=[C01621A0:01C614E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: David S. Miller

>I think merges with conflicts that need to get resolved by hand create
>a lot of noise and useless information and therefore to me they are
>pointless.  But this is just my opinion.  It simply works easier to me
>to shuffle the patches in by hand and deal with the rejects one by
>one.  It's very much akin to how Andrew's -mm tree works.

I guess in this model you can do all your development with quilt,
and the value of git is a high-bandwidth bransport medium to
replace e-mail.

>I think a clean history is worth an extra few minutes of someone's
>time.  And note that subsystem development is largely linear anyways.

Maybe true in your neck of the woods, but not true here.

I have more than a dozen topic branches in my tree, and they mature
at different rates.

When a topic branch is in the test tree and and a follow-up patch
is needed, I check out that topic branch and put the patch
exactly in non-linear 3D history where it is meant to live.
When the topic seems fully baked, I can pull the top of the
branch into the release tree.

-Len
