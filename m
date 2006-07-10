Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWGJPVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWGJPVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWGJPVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:21:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:31182 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422659AbWGJPVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:21:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1
Date: Mon, 10 Jul 2006 17:22:09 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060709021106.9310d4d1.akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101722.09267.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 11:11, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/

The sk98lin driver stopped working on my box.  It loads, but doesn't seem to
do anything else.  Fortunately skge forks just fine, so it's not a big deal.

]--snip--[ 
> - There are some improvements to the swsusp disk IO handling.  You should
>   find that the suspend-time writeout and resume-time readin speeds are
>   approximately doubled.

The swsusp IO changes work very well for me, and that's a huge improvement.
Thanks a lot for it.

Rafael
