Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265417AbTLHPND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbTLHPND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:13:03 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:34790 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265417AbTLHPNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:13:01 -0500
Subject: Re: [BK PATCH 0/3] Teach kbuild to pull files from BK repository
From: David Dillow <dave@thedillows.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.33.0312072204020.13188-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0312072204020.13188-100000@sweetums.bluetronic.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1070896378.2550.109.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Dec 2003 10:12:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-07 at 22:06, Ricky Beam wrote:
> On 4 Dec 2003, David Dillow wrote:
> >I finally got tired of having to run "bk -r get" before doing a build, so I
> ...
> 
> This is not necessary...

>   # cramer / why isn't this the default?
>   []checkout:get
> 
> That last line is the magic.  It's documented in the BK FAQ (more than once
> I think.)

Yes, and most of my repositories are set that way. But I like having the
option of not needing that line, and it was interesting to see how to
make it work properly.

Besides, it still does the get, just at a clone/pull time, and you have
gobs of extra files laying around.

Dave
