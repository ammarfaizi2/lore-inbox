Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWBFOwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWBFOwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWBFOwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:52:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61091 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932139AbWBFOwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:52:37 -0500
Date: Mon, 6 Feb 2006 15:52:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mark Lord <lkml@rtr.ca>
Cc: Nigel Cunningham <nigel@suspend2.net>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206145224.GC1675@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041954.22484.nigel@suspend2.net> <20060204192924.GC3909@elf.ucw.cz> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz> <43E761EB.3030203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E761EB.3030203@rtr.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-02-06 09:49:15, Mark Lord wrote:
> >I'm not sure if we want to save full image of memory. Saving most-used
> >caches only seems to work fairly well.
> 
> No, it sucks.  My machines take forever to become usable on resume
> with the current method.  But dumping full image of memory will need
> compression to keep that from being sluggish as well.

Are you sure? This changed recently, be sure to set
/sys/power/image_size.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
