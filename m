Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTLPVzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTLPVzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:55:45 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:44043 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262901AbTLPVzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:55:39 -0500
Date: Tue, 16 Dec 2003 22:56:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: sensors@stimpy.netroedge.com
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] sensors chip updates
Message-Id: <20031216225614.7824d575.khali@linux-fr.org>
In-Reply-To: <20031216035219.GA1658@earth.solarsys.private>
References: <20031216035219.GA1658@earth.solarsys.private>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following are four patchsets for 2.6 which were either direct
> from or inspired by recent updates in the lm_sensors CVS.
> 
> These patches should be applied, in order, on top of your -test11
> megapatch.  Please queue these up for inclusion after 2.6.0.

Checked to apply correctly, with my other patches too. Checked to
compile too. Not tested to work since I don't have a system running 2.6
these days (hopefully such a situtation won't last) but I'm confident
(the same changes were made to our CVS repository some times ago after
all).

I've added these patches to my personal i2c-related for-Linux-2.6
patches repository [1], and regenerated my own "megapatch" (which is a
superset of Greg's one, and will melt after Greg's changes are actually
merged into the 2.6 kernel). You'll notice that I've merged parts 2 and
3 into one single patch, since both do the same thing on different
drivers.

Thanks Mark for the patches, we really need to keep merging our CVS
changes to Linux 2.6 each time it applies.

[1] http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/
mirrored at http://delvare.nerim.net/i2c/linux-2.6/.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
