Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUJWPBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUJWPBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUJWPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 11:01:15 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:1764 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261200AbUJWPAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 11:00:51 -0400
Date: Sat, 23 Oct 2004 16:00:45 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
In-Reply-To: <9e473391041023075436f6983c@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410231557530.11754@skynet>
References: <9e473391041022214570eab48a@mail.gmail.com> 
 <20041023095644.GC30137@infradead.org>  <9e473391041023073578b11eb6@mail.gmail.com>
  <20041023143912.GA32532@infradead.org>  <9e47339104102307441066e4e4@mail.gmail.com>
  <Pine.LNX.4.58.0410231547410.11754@skynet> <9e473391041023075436f6983c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So the plan then is to eliminate the drm_agp structure and use the
> entry points directly. The correct function entry points are already
> exported from AGP so no kernel patch is needed.

It seems like that is the proper way to do it for 2.6....

> Dave, with the AGP fix up, do you think linux-core is ready for kernel
> submission yet?

I'm hoping to look at it tomorrow, I started on it today but got
sidetracked catching up on the changes in CVS and stuff in the kernel
tree.

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

