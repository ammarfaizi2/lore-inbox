Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRDBXGv>; Mon, 2 Apr 2001 19:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRDBXGn>; Mon, 2 Apr 2001 19:06:43 -0400
Received: from smtp.mountain.net ([198.77.1.35]:26387 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131480AbRDBXG1>;
	Mon, 2 Apr 2001 19:06:27 -0400
Message-ID: <3AC9058F.580E268B@mountain.net>
Date: Mon, 02 Apr 2001 19:04:47 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, David Lang <dlang@diginsite.com>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.30.0104021436110.24812-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Sun, 1 Apr 2001, Jeff Garzik wrote:
> 
> > On Sun, 1 Apr 2001, David Lang wrote:
> > > if we want to get the .config as part of the report then we need to make
> > > it part of the kernel in some standard way (the old /proc/config flamewar)
> > > it's difficult enough sometimes for the sysadmin of a box to know what
> > > kernel is running on it, let alone a bug reporting script.
> >
> > Let's hope it's not a flamewar, but here goes :)
> >
> > We -need- .config, but /proc/config seems like pure bloat.
> 
> As a former proponent of /proc/config (I wrote one of the much-debated
> patches), I tend to agree. Debian's make-kpkg does the right thing, namely
> treating .config the same way it treats System-map, putting it in the
> package and eventually installing it in /boot/config-x.y.z. If Redhat's
> kernel-install script did the same it would rapidly become a non-issue.

How about /lib/modules/$(uname -r)/build/.config ? It's already there.

Tom

-- 
The Daemons lurk and are dumb. -- Emerson
