Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbUJ0HXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbUJ0HXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUJ0HXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:23:33 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:61962 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261529AbUJ0HX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:23:27 -0400
To: linux-kernel@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: MAP_SHARED bizarrely slow
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <20041027064527.GJ1676@zax> (David Gibson's message of "Wed, 27
 Oct 2004 16:45:27 +1000")
References: <20041027064527.GJ1676@zax>
X-Hashcash: 0:041027:linux-kernel@vger.kernel.org:017a53f9603beaa8
X-Hashcash: 0:041027:david@gibson.dropbear.id.au:00339d805705f9da
Date: Wed, 27 Oct 2004 00:23:00 -0700
Message-ID: <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:

David> http://www.ozlabs.org/people/dgibson/maptest.tar.gz

David> On a number of machines I've tested - both ppc64 and x86 - the
David> SHARED version is consistently and significantly (50-100%)
David> slower than the PRIVATE version.

Just gave it a test on my laptop and server.  Both are p3.  The
laptop is under heavier mem pressure; the server has just under
a gig with most free/cache/buff.  Laptop is still running 2.6.7
whereas the server is bk as of 2004-10-24.

Buth took about 11 seconds for the private and around 30 seconds
for the shared tests.

So if this is a regression, it predates v2.6.7.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com> <http://jhcloos.com>


