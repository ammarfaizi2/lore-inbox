Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVD1Fkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVD1Fkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVD1Fkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:40:39 -0400
Received: from mail.autoweb.net ([198.172.237.26]:61316 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262023AbVD1Fk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:40:28 -0400
Date: Thu, 28 Apr 2005 01:40:15 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, sam@ravnborg.org,
       Ryan Anderson <ryan@michonline.com>
Subject: Re: [UML] Compile error when building with seperate source and object directories
Message-ID: <20050428054015.GC30308@mythryan2.michonline.com>
References: <1114570958.5983.50.camel@mythical> <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 12:45:15AM +0100, Al Viro wrote:
> On Tue, Apr 26, 2005 at 11:02:38PM -0400, Ryan Anderson wrote:
> > I've been seeing a build error when trying to build User Mode Linux on
> > an x86-32 host (Athlon, fwiw).  The kernel I'm building is a 1-day old
> > pull from git.  This error is not new, though.  I thought it was merely
> > an artifact of a patch stuck in a queue at first so I didn't mention it
> > right away.
> 
> That's because that stuff is not merged yet.  Speaking of which, where does
> the current UML tree live and who should that series be Cc'ed to?

I think you hit the right people with the Cc: list I started with.

> I've got a decent split-up and IMO that should be mergable.  Patches are
> on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of mail.
> That's a sanitized and split version of old UML-kbuild patch.

Thanks, this seems to do the trick.

I had an initial problem, but I think I was just working from a
directory in a bad state, after nuking my output directory and starting
over, it seems to be working just fine.

Thanks for the fix, I have another toy to play with this week now. :)

-- 

Ryan Anderson
  sometimes Pug Majere
