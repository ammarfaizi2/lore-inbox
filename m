Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbWG1MV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWG1MV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWG1MV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:21:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31686 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161130AbWG1MV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:21:27 -0400
Date: Fri, 28 Jul 2006 14:21:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Brown, Len" <len.brown@intel.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728122112.GB4158@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > textual
> 
> good for shell scripts, not clear it is better for C programs
> that have to open a bunch of files by name.
> 
> > sysfs was great for develping tp_smapi
> 
> Wonderful, but isn't the key here how simple it is for HAL
> or X to understand and use the kernel API rather than the
> developers of the kernel driver that implements the API?
> 
> If X were a shell script, I'd say a file per value would
> clearly be the way to go, but it isn't.

Well, lets say "if we go the /dev/XXX way, maintainer will probably
have to create small utility to make battery info available from the
shell".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
