Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUI2B1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUI2B1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUI2B1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:27:20 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:59920 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268139AbUI2B1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:27:18 -0400
Message-ID: <9e473391040928182765efd7ab@mail.gmail.com>
Date: Tue, 28 Sep 2004 21:27:15 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409290009050.11496@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <Pine.LNX.4.58.0409290009050.11496@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single card seems to be working currently. I still can't get multiple
cards going yet. Second card tries to get the context without holding
the lock and errors out.

I'll keep working on it tonight and tomorrow. I'm past the obvious bug
stage now and into the ones where I stare at it for five hours before
I figure out what is wrong.

Still need someone with a Sparc machine to fix the ffb compile.

On Wed, 29 Sep 2004 00:10:18 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> As with Ian, I'm trying to grab the time to review this over the next day
> or two, I have one or two worries but as I haven't read over the code I'll
> wait until I'm ready to dedicate some proper time to it ..

-- 
Jon Smirl
jonsmirl@gmail.com
