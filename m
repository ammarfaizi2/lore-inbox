Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDBTmO>; Mon, 2 Apr 2001 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRDBTmF>; Mon, 2 Apr 2001 15:42:05 -0400
Received: from waste.org ([209.173.204.2]:33401 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S131233AbRDBTlr>;
	Mon, 2 Apr 2001 15:41:47 -0400
Date: Mon, 2 Apr 2001 14:39:55 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Lang <dlang@diginsite.com>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, <lm@bitmover.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0104021436110.24812-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Jeff Garzik wrote:

> On Sun, 1 Apr 2001, David Lang wrote:
> > if we want to get the .config as part of the report then we need to make
> > it part of the kernel in some standard way (the old /proc/config flamewar)
> > it's difficult enough sometimes for the sysadmin of a box to know what
> > kernel is running on it, let alone a bug reporting script.
>
> Let's hope it's not a flamewar, but here goes :)
>
> We -need- .config, but /proc/config seems like pure bloat.

As a former proponent of /proc/config (I wrote one of the much-debated
patches), I tend to agree. Debian's make-kpkg does the right thing, namely
treating .config the same way it treats System-map, putting it in the
package and eventually installing it in /boot/config-x.y.z. If Redhat's
kernel-install script did the same it would rapidly become a non-issue.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

