Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVKKREy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVKKREy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVKKREy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:04:54 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:28891 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750907AbVKKREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:04:53 -0500
Date: Fri, 11 Nov 2005 12:04:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.14.1/2 patch Makefile hunk FAILED
In-reply-to: <200511111648.35632.nick@linicks.net>
To: linux-kernel@vger.kernel.org
Message-id: <200511111204.52149.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511111648.35632.nick@linicks.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 11:48, Nick Warne wrote:
>Hi all,
>
>Just an eyes-up here - applying the combined 2.6.14.1/2 patch from
> kernel.org

I had no such problems here.  My script patches 2.6.14 to 2.6.14.1, then
to 2.6.14.2.  It built and I'm running it right now.

I don't believe the .2 patch I saved from the email includes the .1
patch.  I didn't get the bz2 version however, so it could be combined. 
Somone else will have to clarify that.

>
>http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2F
>v2.6%2Fincr%2Fpatch-2.6.14.1-2.bz2
>
>produces REJ on Makefile when applied to virgin 2.6.14 as EXTRAVERSION
>isn't .1:
>
>
>***************
>*** 1,7 ****
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 14
>- EXTRAVERSION = .1
>  NAME=Affluent Albatross
>
>  # *DOCUMENTATION*
>--- 1,7 ----
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 14
>+ EXTRAVERSION = .2
>  NAME=Affluent Albatross
>
>  # *DOCUMENTATION*
>
>
>
>Simple to fix manually though.
>
>Nick

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Free OpenDocument reader/writer/converter download:
http://www.openoffice.org
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

