Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbTDGMdp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTDGMdp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:33:45 -0400
Received: from tomts17.bellnexxia.net ([209.226.175.71]:50401 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262978AbTDGMdn (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:33:43 -0400
Date: Mon, 7 Apr 2003 08:35:38 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: "vfat" module not autoloaded (2.5.66-bk12)
Message-ID: <Pine.LNX.4.44.0304070830120.1866-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  since i missed several weeks of the kernel list, i'm not sure
if this has been covered, but the vfat module is not autoloaded
during boot time to allow the mounting of my vfat-formatted
windows partition, as it has been in previous versions of the
kernel.

  i have all of the module options selected for this kernel,
and the dos/vfat options have been selected as modules for this
build.

  during boot time, i get error messages that that partition
could not be mounted.  after boot, i still can't mount it
manually until i explicitly "modprobe vfat", something i've
never had to do before.

  thoughts?

rday

p.s.  now that i think about it, there might have been other
instances of failure to autoload modules that i just shrugged
off at the time, but this is the one example that i took the
time to really verify, since it came as such a surprise.

