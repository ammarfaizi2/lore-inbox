Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136205AbRDVQcr>; Sun, 22 Apr 2001 12:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136206AbRDVQc2>; Sun, 22 Apr 2001 12:32:28 -0400
Received: from linuxjedi.org ([192.234.5.42]:32517 "EHLO linuxjedi.org")
	by vger.kernel.org with ESMTP id <S136205AbRDVQcU>;
	Sun, 22 Apr 2001 12:32:20 -0400
Message-ID: <3AE307AD.821AB47C@linuxjedi.org>
Date: Sun, 22 Apr 2001 12:32:45 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ingo.oeser@informatik.tu-chemnitz.de, viro@math.psu.edu
Subject: hundreds of mount --bind mountpoints?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm still working on a packaging system for diskless (quasi-embedded)
devices.  The root filesystem is all tmpfs, and I attach packages inside
it.  Since symlinks in a tmpfs filesystem cost 4k each (ouch!), I'm
considering using mount --bind for everything.  This appears to use very
little memory, but I'm wondering if I'll run into problems when I start
having many hundreds of bind mountings.  Any feel for this?

regards,
	David

--
David L. Parsley
Roanoke College Network Administrator
