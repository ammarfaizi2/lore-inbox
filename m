Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265072AbUEKXsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265072AbUEKXsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUEKXsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:48:11 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:32387 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265060AbUEKXqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:46:31 -0400
Date: Wed, 12 May 2004 00:46:30 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Valdis.Kletnieks@vt.edu
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sf.net
Subject: re: ioctls in drm.h
In-Reply-To: <200405112334.i4BNYdjO018918@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0405120045150.3826@skynet>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org> <20040511222245.GA25644@kroah.com>
            <Pine.LNX.4.58.0405120018360.3826@skynet>
 <200405112334.i4BNYdjO018918@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > care to comment?
>
> Is this a case where somebody is *really* including kernel headers in userspace
> and we need to smack them, or are they using a copy that's been sanitized
> (and possibly fixed)?

hmm drm.h is used by all drm users and it hasn't really been sanitised..
we probably do need to look into what goes where.. are the rules for 32/64
user/kernel ioctls written down anywhere?

Dave.
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

