Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbTGLMzr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 08:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbTGLMzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 08:55:47 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:24073 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S265564AbTGLMzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 08:55:44 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.18 (i586))
Message-Id: <E19bK8w-0004Ij-00@roos.tartu-labor>
Date: Sat, 12 Jul 2003 16:10:26 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elvtune is mentioned here...

DJ> - Several different IO elevators are available to match different types
DJ>   of workload.  You can select which one to use with elvtune.

but deprecated here:

DJ> Deprecated.
DJ> ~~~~~~~~~~~
DJ> - usbdevfs will be going away in 2.7. The same filesystem can
DJ>   be mounted as 'usbfs' in recent 2.4 kernels, and in 2.5.52
DJ>   and above, which is what the filesystem will furthermore be
DJ>   known as.
DJ> - elvtune is deprecated (as are the ioctl's it used).
DJ>   Instead, the io scheduler tunables are exported in sysfs (see below)
DJ>   in the /sys/block/<device>/iosched directory.
DJ>   Jens wrote a document explaining the tunables of the new scheduler at
DJ>   http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/att-deadline-iosched.txt

Maybe just suggest the sysfs interface at once and not mention elvtune?

-- 
Meelis Roos (mroos@linux.ee)
