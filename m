Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTJJBQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTJJBQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:16:04 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:40205 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262703AbTJJBQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:16:02 -0400
Date: Fri, 10 Oct 2003 09:15:01 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: "Ogden, Aaron A." <aogden@unocal.com>
cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       autofs mailing list <autofs@linux.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [autofs] multiple servers per automount
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6B77@slexch2.sugarland.unocal.com>
Message-ID: <Pine.LNX.4.33.0310100910300.7746-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Ogden, Aaron A. wrote:

>
> Yes, we are using the RH kernels as a base, the limit is supposed to be
> 1200+ but my experiments have shown it to be just shy of 800.  Or maybe
> that results is due to a bug in the autofs code.  I think the real
> solution to this problem is Richard Gooch's devfs and kernel 2.6.  It's
> anyone's guess when there will be a distribution using both of those but
> I think Fedora might be the first.
>

Looks like the limit is here to stay as 2.6 looks similar to 2.4 in that
area and udev is destined to be used as a replacement for devfs (which
never caught on). udev does not address this issue either.

Any know if/how this issue will be addressed?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

