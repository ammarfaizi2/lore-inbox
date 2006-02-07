Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWBGXDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWBGXDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWBGXDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:03:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58767 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030235AbWBGXDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:03:37 -0500
Date: Wed, 8 Feb 2006 00:03:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Bojan Smojver <bojan@rexursive.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207230318.GE2753@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602071105.45688.nigel@suspend2.net> <20060207092356.GA1742@elf.ucw.cz> <200602072006.32017.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602072006.32017.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, for _users_ method seems to be clicking "suspend" in KDE. For
> > more experienced users it is powersave -U. And you are already
> > distributing script to do suspend... Just hook suspend2 to the same
> > gui stuff distributions already use.
> 
> The problem is that kpowersave, for example, doesn't provide any way to say 
> that you want to start the cycle by doing something other than echo 
> > /sys/power/state. They're apparently planning on changing it to support 
> suspend2, but should they have to (and why again for uswsusp?).

Fix kpowersave, then.

> > Besides what you described can't work for uswsusp.
> 
> call_usermodehelper

No.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
