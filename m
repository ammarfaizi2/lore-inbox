Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266549AbUFWPIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUFWPIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUFWPIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:08:49 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:8737 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S266549AbUFWPIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:08:34 -0400
Date: Wed, 23 Jun 2004 10:07:54 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Pat Gefre <pfg@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, erikj@sgi.com, devices@lanana.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <20040623150210.GA24133@infradead.org>
Message-ID: <Pine.SGI.4.53.0406231005110.280312@subway.americas.sgi.com>
References: <20040622183621.GA7490@infradead.org>
 <Pine.SGI.3.96.1040623094018.19458B-100000@fsgi900.americas.sgi.com>
 <20040623150210.GA24133@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 23, 2004 at 09:42:17AM -0500, Pat Gefre wrote:
> > Guess I should have said "different" major/minor. We have asked lanana
> > for our own major/minor - but, as yet, no response.... So we picked a
> > different one.
> Please wait a resonse from LANANA then.  As you already have that support
> just kill the SYSFS_ONLY ifdef (which is grossly misnamed, btw - people have
> used dynamic majors and minnors long before sysfs was invented)

Well, the horrible name was my fault.

LANANA has been unresponsive and their site states they aren't accepting
2.6 submissions.

Using dynamic minors doesn't work with many distros.  One distro, for
example, opens the console up before /dev is populated by by sysfs.

So dynamic won't work for us but we left it in for the future and to show
we had tried it.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
