Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVCLX6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVCLX6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVCLX6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:58:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262244AbVCLX6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:58:11 -0500
Date: Sat, 12 Mar 2005 18:58:04 -0500
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: DRI breakage, 2.6.11-mm[123]
Message-ID: <20050312235804.GD32494@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050312034222.12a264c4.akpm@osdl.org> <6uzmx87k48.fsf@zork.zork.net> <6uu0ng7je7.fsf@zork.zork.net> <21d7e9970503121513113ecb81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970503121513113ecb81@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 10:13:49AM +1100, Dave Airlie wrote:
 > On Sat, 12 Mar 2005 19:29:20 +0000, Sean Neakums <sneakums@zork.net> wrote:
 > > Sean Neakums <sneakums@zork.net> writes:
 > > 
 > > > The following happens with 2.6.11-mm[123].  (I didn't have time to
 > > > investigate earlier; sorry.)  It does not happen with 2.6.11-rc3-mm2
 > > > and 2.6.11.  I have tested 2.6.11-mm3 with dri disabled (by not
 > > > loading X's dri module) and it also does not happen then.
 > > 
 > > Also happens on 2.6.11-mm3 with bk-drm.patch reverted.
 > > 
 > > To expand on my crappy report, the graphics card is a Radeon 9200:
 > 
 > Wierd the -mm tree has currently very few drm changes over the non-mm
 > tree and if reverting bk-drm doesn't help it sounds like something in
 > the generic ioctl code may be gone wrong...
 > 
 > Can you try a 2.6.12-bk snapshot.. it may be the multi-head patches
 > are buggy....

Could be. Given the other agp problems didn't get spotted in -mm
my confidence in those patches has dropped off somewhat in the
last few days.

Hopefully it's something simple.

		Dave

