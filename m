Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVAALvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVAALvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 06:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVAALvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 06:51:48 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:48552 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261421AbVAALvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 06:51:46 -0500
Date: Sat, 1 Jan 2005 11:51:44 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Joseph Fannin <jhf@rivenstone.net>
Cc: Dave Airlie <airlied@gmail.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk pull] drm core/personality split
In-Reply-To: <20050101104054.GA14904@samarkand.rivenstone.net>
Message-ID: <Pine.LNX.4.58.0501011150370.31145@skynet>
References: <Pine.LNX.4.58.0412300733380.25314@skynet>
 <21d7e997041229234860454564@mail.gmail.com> <20050101104054.GA14904@samarkand.rivenstone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>     Applying this patch to 2.6.10 shows that the oops-and-crash in
> i810_mmap_buffers I reported in the bk-drm (and -mm) tree is
> here. :(  Vanilla 2.6.10 is fine.
>
>     I'll repeat what I worked out about this for anyone interested; I
> was able to get the i810 DRM working again by reverting this change:
> http://drm.bkbits.net:8080/drm-2.6/cset@418a0608l2KOkX2bWPW4DYyiQfa69A?nav=index.html|ChangeSet@-4w
>

I've figured this out, your change is actually partly correct, there is a
bit more that needs to be done though, I'll post a patch tomorrow
hopefully...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

