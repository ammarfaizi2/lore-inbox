Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266236AbSKON06>; Fri, 15 Nov 2002 08:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbSKON05>; Fri, 15 Nov 2002 08:26:57 -0500
Received: from ns.tasking.nl ([195.193.207.2]:31761 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S266236AbSKON05>;
	Fri, 15 Nov 2002 08:26:57 -0500
Date: Fri, 15 Nov 2002 14:32:50 +0100
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
Message-ID: <20021115133250.GA16834@altium.nl>
Reply-To: frank.van.maarseveen@altium.nl
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114193156.A2801@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.27i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
From: fvm@altium.nl (Frank van Maarseveen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 07:31:56PM -0500, Pete Zaitcev wrote:
> > > 2. How do these changes sit with LLNL's changes to increase
> > >    number of groups that NFS client can support? It's not
> > >    a showstopper, but would be nice if you two cooperated.
> > 
> > hmm, I haven't heard anything about them - can you offer an email or URL?
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.0/0788.html
> 
> The sad part is that the patch was around since 2000, but the
> effort to get it in was a little half-hearted, perhaps.
> I am thinking about reviving it.

It's still alive. I'll make a 2.4.20 version of the patch once 2.4.20
is released. Or maybe earlier (a -rc version) since 2.4.20 appears to
be imminent and I don't expect changes in that area. 2.5.latest is next
on my list. Latest version is:

http://web.inter.nl.net/users/fvm/nfs-ngroups/2.4.19-nfs-ngroups-3.98.patch

I have dropped all the older versions (they go back to 2.2.13)

-- 
Frank
