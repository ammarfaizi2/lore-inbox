Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbTCZGvN>; Wed, 26 Mar 2003 01:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbTCZGvN>; Wed, 26 Mar 2003 01:51:13 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24083
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261491AbTCZGvL>; Wed, 26 Mar 2003 01:51:11 -0500
Date: Tue, 25 Mar 2003 22:59:11 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Matt Mackall <mpm@selenic.com>
cc: Jeff Garzik <jgarzik@pobox.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <20030326055525.GA20244@waste.org>
Message-ID: <Pine.LNX.4.10.10303252222060.25072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Matt Mackall wrote:

> > Yeah, iSCSI handles all that and more.  It's a behemoth of a 
> > specification.  (whether a particular implementation implements all that 
> > stuff correctly is another matter...)
> 
> Indeed, there are iSCSI implementations that do multipath and
> failover.
> 
> Both iSCSI and ENBD currently have issues with pending writes during
> network outages. The current I/O layer fails to report failed writes
> to fsync and friends.
> 
> > BTW, I'm a big enbd fan :)  I like enbd for it's _simplicity_ compared 
> > to iSCSI.
> 
> Definitely. The iSCSI protocol is more powerful but _much_ more
> complex than ENBD. I've spent two years working on iSCSI but guess
> which I use at home..

To be totally fair ENBD/NBD is not SAN nor will it ever become a qualified
SAN.  I would like to see what happens to your data if you wrap your
ethernet around a ballast resistor or even run it near by the associated
light fixture, and blink the the power/lights.  This is where goofy people
run cables in the drop ceilings.

We have almost finalized our initiator to be submitted under OSL/GPL.
This will be a full RFC ERL=2 w/ Sync-n-Steering.

I have seen to much GPL code stolen and could do nothing about it.

While the code is not in binary executable form it shall be under OSL
only.  Only at compile and execution time will it become GPL compliant
period.  This is designed to extend the copyright holders rights to force
anyone who uses the code and changes anything to return to open to the
copyright holder period.  Additional language may be added to permit not
return code to exist under extremely heavy licensing fees to be used to
promote OSL projects and assist any GPL holder with litigation fees to
protect their rights.  To many of us do not have the means to defend our
copyrights, this is one way I can see to provide a plausable solution to a
dirty problem.  This may not be the best answer but it is doable.  This
will apply some teeth into the license to stop this from happening again.

Like it or hate it, OSL/GPL looks to be the best match out there.

Regards,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

