Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267931AbUGaJ5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267931AbUGaJ5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267930AbUGaJ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:57:30 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41098 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267931AbUGaJ5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:57:24 -0400
Subject: Re: drm - first steps towards 64-bit correctness..
From: Eric Anholt <eta@lclark.edu>
To: arjanv@redhat.com
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       DRI <dri-devel@lists.sourceforge.net>
In-Reply-To: <1091267687.2819.3.camel@laptop.fenrus.com>
References: <Pine.LNX.4.58.0407310940540.6368@skynet>
	 <1091266345.425.34.camel@leguin>
	 <1091267687.2819.3.camel@laptop.fenrus.com>
Content-Type: text/plain
Message-Id: <1091267836.425.46.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 02:57:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 02:54, Arjan van de Ven wrote:
> On Sat, 2004-07-31 at 11:32, Eric Anholt wrote:
> > As long as you don't use the linux-y
> > "u32"-type types, BSD should be happy with the changes.
> 
> can you explain why u32 would be outlawed? Surely it's trivial to do a
> typedef for u32 on BSD for drm ??

If there are nice standard types (uint32_t or u_int32_t, can't remember
which at the moment, I mentioned it in an email some time ago) out there
already that linux has too, why not use those?

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


