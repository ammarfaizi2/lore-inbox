Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUGaLCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUGaLCx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 07:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267944AbUGaLCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 07:02:52 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:58269 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267943AbUGaLCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 07:02:51 -0400
Date: Sat, 31 Jul 2004 12:02:25 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Eric Anholt <eta@lclark.edu>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org,
       DRI <dri-devel@lists.sourceforge.net>
Subject: Re: drm - first steps towards 64-bit correctness..
In-Reply-To: <1091267836.425.46.camel@leguin>
Message-ID: <Pine.LNX.4.58.0407311157090.11228@skynet>
References: <Pine.LNX.4.58.0407310940540.6368@skynet>  <1091266345.425.34.camel@leguin>
  <1091267687.2819.3.camel@laptop.fenrus.com> <1091267836.425.46.camel@leguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > can you explain why u32 would be outlawed? Surely it's trivial to do a
> > typedef for u32 on BSD for drm ??
>
> If there are nice standard types (uint32_t or u_int32_t, can't remember
> which at the moment, I mentioned it in an email some time ago) out there
> already that linux has too, why not use those?
>

Lets get this bit of the discussion over with :-), the kernel has uint*_t
in it in a few places, this is now a standard type so we will use it, if
someone is going to work on the DRM they'll see the surrounding uint32_t
so they'll know what it looks like and I'll make sure none of the others
sneak in....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

