Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJURsi>; Mon, 21 Oct 2002 13:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSJURsh>; Mon, 21 Oct 2002 13:48:37 -0400
Received: from main.gmane.org ([80.91.224.249]:35290 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261495AbSJURsf>;
	Mon, 21 Oct 2002 13:48:35 -0400
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Linux v2.5.44 - and offline for a week
Date: Mon, 21 Oct 2002 13:55:35 -0400
Message-ID: <ap1ev5$1ag$1@main.gmane.org>
References: <Pine.LNX.4.44.0210182117500.12531-100000@penguin.transmeta.com> <aorjq3$3dm$1@main.gmane.org> <200210201749.41625.landley@trommello.org> <20021021131137.GA12708@suse.de>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1035222821 1360 130.127.121.177 (21 Oct 2002 17:53:41 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Mon, 21 Oct 2002 17:53:41 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Sun, Oct 20, 2002 at 05:49:41PM -0500, Rob Landley wrote:
> 
>  > There will always be code that's not ready before the freeze, and that
>  > won't
>  > make it in.  If this wasn't the case, there wouldn't be a need for a
>  > cutoff
>  > date, would there?  "Oh, development is over, there are no more
>  > interesting
>  > new patches anywhere, we can all go home now."  Doesn't happen.
> 
> Likewise, there _will_ be /some/ things that go in after the freeze.
> 
> - Things that are broken now that absolutely need fixing at all costs
>   before the freeze. Thankfully, most of this work seems to be driver
>   work. Some subsystems (ISDN, i2o, some of the net protos) need some
>   more indepth surgery, but this is imo all valid work that can happen
>   post freeze.
> - Zero impact features.
>   As an example, now that the x86 subarch support is merged, even quite
>   large things, like support for Voyager has no impact on anything else
>   now. Likewise new filesystems as long as it doesn't require VFS
>   changes. (Something the Reiser4 folks seem to have realised).
> - "Oops, this is totally broken" features.
>   There still seems no concensus on volume management for 2.6
>   Leaving existing LVM1 users dead in the water with the reply
>   "leave it to vendors to add the dm/evms patch" just doesn't seem
>   right. We need *something* for 2.6
> 

Thanks Dave, those were exactly the features I was worried about not getting 
in 2.6.

Cheers,
Nicholas


