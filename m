Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUIUMVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUIUMVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUIUMVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:21:41 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:15297 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267612AbUIUMVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:21:39 -0400
Date: Tue, 21 Sep 2004 13:21:38 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK tree] [drm] remove counter macros..
In-Reply-To: <20040921130936.A22429@infradead.org>
Message-ID: <Pine.LNX.4.58.0409211316310.22187@skynet>
References: <Pine.LNX.4.58.0409211148290.22187@skynet> <20040921130936.A22429@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well this was only a direct macro removal, I'm contemplating removing the
counters as to be honest I'm not sure any drm developer as actually used
them since day one .. (and maybe not even then)... but I'll leave that for
another time, as there might be a wierd use of them somewhere...

Once I drop the ioctl macro, I'll probably start going back to see what
stuff is probably not of any use anymore.. (counters are fairly high on
that list..)..

Dave.

On Tue, 21 Sep 2004, Christoph Hellwig wrote:

> While I definitly approve this patch is there a specific reason for this
> array instead of individual members like
>
> 	lock_cnt, open_cnt, close_cnt, etc..?
>
> also the optional counters seem to be largely overlapping, why not always
> all four thta exist and if some drivers don't want to update them they'd
> just not update them
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

