Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVCMMsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVCMMsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 07:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCMMsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 07:48:43 -0500
Received: from zork.zork.net ([64.81.246.102]:64673 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261199AbVCMMsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 07:48:41 -0500
From: Sean Neakums <sneakums@zork.net>
To: Dave Jones <davej@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DRI breakage, 2.6.11-mm[123]
References: <20050312034222.12a264c4.akpm@osdl.org>
	<6uzmx87k48.fsf@zork.zork.net> <6uu0ng7je7.fsf@zork.zork.net>
	<21d7e9970503121513113ecb81@mail.gmail.com>
	<20050312235804.GD32494@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Dave Airlie
	<airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Date: Sun, 13 Mar 2005 12:48:21 +0000
In-Reply-To: <20050312235804.GD32494@redhat.com> (Dave Jones's message of
	"Sat, 12 Mar 2005 18:58:04 -0500")
Message-ID: <6ull8r7luy.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Sun, Mar 13, 2005 at 10:13:49AM +1100, Dave Airlie wrote:
>  > On Sat, 12 Mar 2005 19:29:20 +0000, Sean Neakums <sneakums@zork.net> wrote:
>  > > Sean Neakums <sneakums@zork.net> writes:
>  > > 
>  > > > The following happens with 2.6.11-mm[123].  (I didn't have time to
>  > > > investigate earlier; sorry.)  It does not happen with 2.6.11-rc3-mm2
>  > > > and 2.6.11.  I have tested 2.6.11-mm3 with dri disabled (by not
>  > > > loading X's dri module) and it also does not happen then.
>  > > 
>  > > Also happens on 2.6.11-mm3 with bk-drm.patch reverted.
>  > > 
>  > > To expand on my crappy report, the graphics card is a Radeon 9200:
>  > 
>  > Wierd the -mm tree has currently very few drm changes over the non-mm
>  > tree and if reverting bk-drm doesn't help it sounds like something in
>  > the generic ioctl code may be gone wrong...
>  > 
>  > Can you try a 2.6.12-bk snapshot.. it may be the multi-head patches
>  > are buggy....
>
> Could be. Given the other agp problems didn't get spotted in -mm
> my confidence in those patches has dropped off somewhat in the
> last few days.
>
> Hopefully it's something simple.

Same symptoms with 2.6.11-bk8.

-- 
Dag vijandelijk luchtschip de huismeester is dood
