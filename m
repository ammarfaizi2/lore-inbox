Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132022AbQKXHAy>; Fri, 24 Nov 2000 02:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132082AbQKXHAp>; Fri, 24 Nov 2000 02:00:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:60174
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S132022AbQKXHA2>; Fri, 24 Nov 2000 02:00:28 -0500
Date: Thu, 23 Nov 2000 22:30:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.GSO.4.21.0011240103021.12702-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10011232216270.4479-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Alexander Viro wrote:

> 
> 
> On Thu, 23 Nov 2000, Andre Hedrick wrote:
> 
> > What the F*** does that have to do with the price of eggs in china, heh?
> > Just maybe if you could follow a thread, you would see that that Alex Viro
> > has pointed out that changes in the FS layer as dorked things.
> 
> ?
> If you have a l-k feed from future - please share. I'm not saying that

Date: Thu, 23 Nov 2000 04:37:21 -0500 (EST)

> fs/* is not the source of that stuff, but I sure as hell had not said
> that it is. I simply don't know yet.

You were pointing out changes to reproduce the effect.

> > Since there have been not kernel changes to the driver that effect the
> > code since 2.4.0-test5 or test6 and it now randomly shows up after five or
> > six revisions out from the change, and the changes were chipset only.
> 
> generic_unplug_device() was changed more or less recently. I doubt that
> it is relevant, but...

Cool, the issue was that I get tried of people blaming the ATA subsystem
for things that it does not do or has control over.  Basically, I kill
bogus threads that try to tag me with an old problem of the past that was
a hardware issue.

Given the latest stats that more than 90% of the linux install base is
hinged on me getting the low-level engine core correct, I go on benders
when cheap shots are take across the bow.

Now the only issue that is even on the radar map is a potential 1GB cross
copy execution where I have a single report that md5sums do not match.
I have yet to reproduce it even with the identical hardware sent to me.

I questioned _A_ about this and there may be a case that is OS independent
which is more important to me than other.  This is a non-fixable for
6->12 months, until I kick some tail in the standards committee meetings
over this point.  If it is a reality, Linux and Microsoft will join as the
OS's represented there and force the change.  Only because there are
potentical side-bars that NT is effected also in these rare cases.

Cheers,

Andre Hedrick
Linux ATA Development


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
