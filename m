Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVCCWTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVCCWTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVCCWRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:17:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:39094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262676AbVCCWOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:14:31 -0500
Date: Thu, 3 Mar 2005 14:13:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: miklos@szeredi.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
Message-Id: <20050303141352.32c6c35d.akpm@osdl.org>
In-Reply-To: <16935.12745.191707.91582@alkaid.it.uu.se>
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
	<20050302123123.3d528d05.akpm@osdl.org>
	<16934.54647.354607.902748@alkaid.it.uu.se>
	<20050303013203.245c8833.akpm@osdl.org>
	<16935.12745.191707.91582@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
>  > > perfctr has one API update pending, and then the API should be
>   > > in it final-ish form. David Gibson at IBM has done a ppc64 port,
>   > > which is about ready to be merged, and someone else has just
>   > > started working on a mips port.
>   > > 
>   > 
>   > That sounds good.  Where do we stand now with ia64?  Do we just end up
>   > agreeing to differ?
> 
>  I think so, yes.
> 
>  The ia64 perfmon has some features perfctr doesn't have,
>  but my perfctr API changes will allow perfctr to grow its
>  feature list and adapt to HW changes without breaking the API.
>  Its unlikely that perfctr will ever implement everything
>  perfmon does, but multiplexing and overflow sample buffering
>  are two features that should be added at some point.

Oh well, at least we tried.  perfctr supports a lot of architectures and a
fair few people want it, so let's get this merged up.

Let's get the ppc64 port included too, just in case that forces
late-breaking API changes.

