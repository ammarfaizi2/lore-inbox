Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSCHUPl>; Fri, 8 Mar 2002 15:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310140AbSCHUPb>; Fri, 8 Mar 2002 15:15:31 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:61445 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S288071AbSCHUPR>;
	Fri, 8 Mar 2002 15:15:17 -0500
Date: Fri, 8 Mar 2002 21:15:07 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <Pine.LNX.4.44L.0203081334250.2181-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0203082059180.2580-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Rik van Riel wrote:

> On Fri, 8 Mar 2002, Pau Aliagas wrote:
> 
> > I'd recommend everybody to give arch a try.
> 
> If you could setup a public arch repository of the 2.4 / 2.5
> kernel of which everybody can copy/clone their arch kernel
> repository, that would be a good start.

It is not necessary to setup a central repository.

We need a reference archive to keep in sync with; then everybody branches
from there and syncs back and forth. The reference archive would be the
official kernel branch.

You could then have public archives to share your patchsets. And access 
other's archives who you are interested in staying in sync with.

> Even better would be an arch kernel repository that is kept
> up-to-date (automatically?) or gated from the bitkeeper tree.

We only need to update to the latest kernel to have the repository
updated, nothing else. You commit the patchset as "patch-2.5.6" and that's
it. Then you grep you kernel25--rik and apply the changes from the
official branch automatically, reconciling differences. Once you want to 
"export" your changes to Linus, you export it in one or more patchsets.

> That would give us some real way to compare the two tools.

It seems obvious that bitkeeper is in very good shape; I'm not at all
against people using, but I'm sure that if a few people tried arch, they'd 
be gratefully surprised. Testing and improvement is needed and very 
welcome as well as kernel hackers aiming to try it.

Pau

