Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTFCTk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTFCTk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:40:27 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:38106 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263365AbTFCTk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:40:26 -0400
Date: Tue, 3 Jun 2003 14:54:21 -0400
From: Ben Collins <bcollins@debian.org>
To: Jocelyn Mayer <jma@netgem.com>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-ID: <20030603185421.GB10102@phunnypharm.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com> <20030602163443.2bd531fb.georgn@somanetworks.com> <1054588832.4967.77.camel@jma1.dev.netgem.com> <20030603113636.GX10102@phunnypharm.org> <1054663917.4967.99.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054663917.4967.99.camel@jma1.dev.netgem.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First, I never trust hotplug or other tools like this:
> I do all insmod by hand, so I know all drivers have been loaded.
> What is hotplug supposed to do (but wasn't in previous driver
> version...) ?

I didn't say CONFIG_HOTPLUG, I said hotplug. Basically SCSI in 2.4 will
not let recognize devices that were not present when the scsi-host was
initially registered with the SCSI stack. You have to run
rescan-scsi-bus.sh (or manually send the add/remove commands via
procfs).

Please read the linux-kernel and/or linux1394-devel mailing list
archives. I really hate dredging this all up again.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
