Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVJ0UVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVJ0UVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJ0UVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:21:30 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:26307 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932211AbVJ0UV3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:21:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nSHwXDMOR3NQA1J3JtsOE11grIMZKjA7QSVwb5rgJ+Dsjz1DvJxnC5VOWm9EDinF1Q/1vNuweAbWUI221Hqu2Ka2vMAHVtV31XhB8YI1MqifFPKZ0VeoKRO/8hkfsxbolUjae/WuhZbKVlvh9ck7LP5Y7gImNfM7+6GlCRgNDmg=
Message-ID: <21d7e9970510271321l3a8cd145r9ecd2380de568e21@mail.gmail.com>
Date: Fri, 28 Oct 2005 06:21:28 +1000
From: Dave Airlie <airlied@gmail.com>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.14-rc5: X spinning in the kernel [ Was: 2.6.14-rc5 GPF in radeon_cp_init_ring_buffer()]
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1130426711.23729.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0510261103510.24177@skynet>
	 <82b32ed40510262111m2e3b749yca4f78982e879e5e@mail.gmail.com>
	 <1130426711.23729.61.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an X hang.. and I'd seriously doubt it has anything to do with
the kernel at that point..

A really hacky patch somehow has made its way into X.org releases from
a few vendors and it seems to break PCI GART system really badly on
first boot... I'm not the happiest person with RH/Dell/ATI engineering
at the moment who were all involved....

Benh is working on fixing this up in X.org but I've no idea how long
it will take to reach the real world...

Dave.
