Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLPEKU>; Fri, 15 Dec 2000 23:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLPEKK>; Fri, 15 Dec 2000 23:10:10 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:8467 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129319AbQLPEJv>; Fri, 15 Dec 2000 23:09:51 -0500
Date: Fri, 15 Dec 2000 19:37:49 -0800 (PST)
From: ferret@phonewave.net
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
In-Reply-To: <20001215195611.L829@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.3.96.1001215193529.19208C-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Ingo Oeser wrote:

> On Fri, Dec 15, 2000 at 09:31:57AM -0800, ferret@phonewave.net wrote:
> > > Maybe you did not notice, but for months we have
> > > /lib/modules/`uname -r`/build/include, which points to kernel headers,
> > > and which should be used for compiling out-of-tree kernel modules
> > > (i.e. latest vmware uses this).
> > 
> > This symlink really should be a copy instead, because the finished kernel
> > may be installed on a machine that does not have kernel source installed
> > on it. Dangling symlinks are BAD.
> 
> But if you compile for another machine, this copy is bad. It also
> takes to much time and space to create this copy.
> 
> I really disagree here.

Do you have an alternative reccomendation? I've shown where the symlink
method WILL fail. You disagree that having the configured headers copied
is a workable idea. What else is there?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
