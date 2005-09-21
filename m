Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVIUQfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVIUQfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVIUQfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:35:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751141AbVIUQfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:35:50 -0400
Date: Wed, 21 Sep 2005 09:35:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, len.brown@intel.com,
       Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
In-Reply-To: <20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
 <20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Sep 2005, Pavel Machek wrote:
> 
> I think you are not following the proper procedure. All the patches
> should go through akpm.

One issue is that I actually worry that Andrew will at some point be where 
I was a couple of years ago - overworked and stressed out by just tons and 
tons of patches. 

Yes, he's written/modified tons of patch-tracking tools, and the git 
merging hopefully avoids some of the pressures, but it still worries me. 
If Andrew burns out, we'll all suffer hugely.

I'm wondering what we can do to offset those kinds of issues. I _do_ like 
having -mm as a staging area and catching some problems there, so going 
through andrew is wonderful in that sense, but it has downsides.

Andrew?

			Linus
