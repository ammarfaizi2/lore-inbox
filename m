Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWARQrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWARQrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWARQrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:47:17 -0500
Received: from khc.piap.pl ([195.187.100.11]:58125 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030401AbWARQrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:47:16 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
	<B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
	<43CD8A19.3010100@cfl.rr.com>
	<7A7A0F7F294BB08D7CDA264C@d216-220-25-20.dynip.modwest.com>
	<43CDA3B0.2030503@cfl.rr.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 18 Jan 2006 17:47:08 +0100
In-Reply-To: <43CDA3B0.2030503@cfl.rr.com> (Phillip Susi's message of "Tue, 17 Jan 2006 21:10:56 -0500")
Message-ID: <m3wtgxwkj7.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> but only slightly so, and in any case, a 3 disk raid-5 is FAR more
> reliable than a single drive, and only slightly less reliable than a
> two disk raid-1 ( though you get 3x the space for only 50% higher
> cost, so 6x cheaper cost per byte of storage ).

Actually with 3-disk RAID5 you get 2x the space of RAID1 for 1.5 x cost,
so the factor is 1.5/2 = 0.75, i.e., you save only 25% on RAID5 or RAID1
is 33% more expensive.
-- 
Krzysztof Halasa
