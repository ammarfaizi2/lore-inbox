Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWC3Nnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWC3Nnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWC3Nnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:43:50 -0500
Received: from ns1.suse.de ([195.135.220.2]:40424 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932210AbWC3Nnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:43:49 -0500
Date: Thu, 30 Mar 2006 15:43:09 +0200
From: Stefan Seyfried <seife@suse.de>
To: gene.heskett@verizononline.net
Cc: linux-kernel@vger.kernel.org,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Possible breakage in 2.6.16?
Message-ID: <20060330134309.GB4627@suse.de>
References: <200603281244.24906.gene.heskett@verizon.net> <Pine.LNX.4.61.0603281316480.23823@chaos.analogic.com> <200603281603.53561.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603281603.53561.gene.heskett@verizon.net>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586) Beta8, Kernel 2.6.16-2-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 04:03:53PM -0500, Gene Heskett wrote:

> It appears strace does about 5-6 pages of its own setup, then this:
> --------------------open("/root/bin/netstat", O_RDONLY|O_LARGEFILE) = 3

you are running /root/bin/netstat, not the netstat that came with your
rpm...

> ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xaf86e2e8) = -1 ENOTTY 
> (Inappropriate ioctl for device)
> _llseek(3, 0, [0], SEEK_CUR)            = 0
> read(3, "#!/bin/bash\nreset\nwhile [ 1 ] ; "..., 80) = 80

...and it is a script. Care to show us the script?
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
