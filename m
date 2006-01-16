Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWAPCuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWAPCuU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWAPCuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:50:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:12809 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932172AbWAPCuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:50:19 -0500
Date: Mon, 16 Jan 2006 03:50:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: fix make -jN with multiple targets with make O=...
Message-ID: <20060116025003.GA7656@mars.ravnborg.org>
References: <dqev9f$pnc$1@sea.gmane.org> <7627.1137378243@kao2.melbourne.sgi.com> <dqf16n$4tn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dqf16n$4tn$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 11:42:30AM +0900, Kalin KOZHUHAROV wrote:
 >> When did it break? Are any of the released (not -git) kernels affected?
> > 
> > 2.6.15 has the problem.  It only triggers with the combination of a
> > separate object directory _and_ multiple targets on the make command
> > line _and_ running make in parallel (make -j).
I have not tested, but I beleive the bug has been present since day one
of the make O=... feature inclusion.

 
> Please get that patch into 2.6.15.2 if possible (seems many people have ppp
> problems, so I guess that will be released soon).
Since it has been present for long then we are not in a big hurry.
One report in many months.

	Sam
