Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUB0IdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 03:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbUB0IdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 03:33:05 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:56582 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261739AbUB0IdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 03:33:02 -0500
Message-ID: <1077870909.403f013dd04b6@imp.gcu.info>
Date: Fri, 27 Feb 2004 09:35:09 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       sensors@Stimpy.netroedge.com
Subject: Re: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <403E82D8.3030209@gmx.de> <20040225185536.57b56716.akpm@osdl.org> <20040227001115.GA2627@werewolf.able.es> <20040227004602.GB15075@kroah.com>
In-Reply-To: <20040227004602.GB15075@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

> Anyway, I think all you need to do is get the cvs tree of the
> lmsensors package.  Sensors people, the needed changes are commited
> into the tree, right?

No. The changes are waiting in my local repository, ready to be applied.
I didn't want to apply them because we were supposed to release
lm_sensors 2.8.5 (for Linux 2.6.3 users) and the sysfs names change
wouldn't belong there.

The libsensors patches are available on my personal server here:
http://jdelvare.net1.nerim.net/sensors/
Apply both patches in order and you'll get a 2.6.3-mm4-compliant
library.

I will apply the libsensors changes to the CVS repository as soon as the
kernel modules changes are accepted into Linus' tree. If we did not
release a new version since there, I'll take a CVS snapshot right
before so that Linux 2.6.3 users have a usable version available (but
my preference strongly goes to releasing 2.8.5 instead).

Thanks for testing.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

