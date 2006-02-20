Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWBTKgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWBTKgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWBTKgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:36:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51861 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964857AbWBTKgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:36:31 -0500
Date: Mon, 20 Feb 2006 11:36:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220103616.GC16042@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <20060220094300.GC19293@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220094300.GC19293@kobayashi-maru.wspse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 10:43:00, Matthias Hensler wrote:
> Hi.
> 
> On Sun, Feb 19, 2006 at 10:29:52PM +0100, Pavel Machek wrote:
> > Maybe very little of substance is being done in userspace, but all the
> > uglyness can stay there. I no longer need LZF in kernel, special
> > netlink API for progress bar (progress bar naturally lives in
> > userland), no plugin infrastructure needed, etc.
> 
> Linux has a whole crypto API in the kernel, so why is it a problem to
> have LZF there too?

Because it is not needed there?

> About the progress bar: this is already implemented in userspace, the
> kernel just forwards the progress via netlink to it. Not necessarily
> ugly I think.

Look at the code.
							Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
