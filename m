Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTD3TBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTD3TBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:01:35 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:30625 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262361AbTD3TBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:01:33 -0400
Date: Wed, 30 Apr 2003 21:11:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030430191144.GC10102@elf.ucw.cz>
References: <20030429155731.07811707.akpm@digeo.com.suse.lists.linux.kernel> <p73r87k3gx9.fsf@oldwotan.suse.de> <20030430180922.GB453@elf.ucw.cz> <20030430181517.GA22761@Wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430181517.GA22761@Wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Generic item: 
> > > 
> > > - need to share the ioctl 32bit emulation handlers between ports. 
> > > Pavel has a patch, but he's running into difficulties with merging it.
> > 
> > Its in now.
> 
> Yes and nothing compiles anymore because linux/compat_ioctl.h is
> missing.

Oops, sorry. Patch is on its way to Linus.

> And really the table merge is not enough - all the functions need to 
> be shared too.

Yes, I know. And it is going to be quite a big task, but table merge
is good first step.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
