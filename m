Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTAKIUx>; Sat, 11 Jan 2003 03:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbTAKIUw>; Sat, 11 Jan 2003 03:20:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34834
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267162AbTAKIUw>; Sat, 11 Jan 2003 03:20:52 -0500
Date: Sat, 11 Jan 2003 00:27:32 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: More on Linux and iSCSI [info, not flame :)]
In-Reply-To: <20030111081440.GU14778@waste.org>
Message-ID: <Pine.LNX.4.10.10301110020440.31168-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Oliver Xymoron wrote:

> On Sat, Jan 11, 2003 at 12:01:05AM -0800, Andre Hedrick wrote:
> > 
> > Oliver et al.
> > 
> > http://downloadfinder.intel.com/scripts-df/filter_results.asp?strOSs=19%2C24%2C39&strTypes=DRV%2CFRM%2CUTL&ProductID=844&OSFullName=&submit=Go%21
> > http://downloadfinder.intel.com/scripts-df/proc/T8Clearance.asp?url=/4461/eng/Zama2_1.0.8_Linux_42715.tgz&agr=N
> > 
> > This self extracting file contains the firmware and software for the 
> > upgrading to 0.8 iSCSI specification.
> > 
> > I own this product, and have to install RH 7.1 w/ 2.4.2 kernels to use and
> > test with it.
> 
> Which means, like every other binary module, it's pretty much
> worthless. Though I'm guessing that's not the point you're trying to
> make.
> 
> (For the record, there's not much value in iSCSI NICs, or TCP offload
> in general at the moment, except to avoid potential deadlock issues
> with trying to do network buffer allocation down in the block layer)

Well if you restrict the transport of the protocol to on Network Fabric,
you have a small point.  However moving off the Network stack to MPI
transports is real power of the protocol.  Classic example is the IBM
iSCSI Shark running Linux, and where are the their drivers?  Recall they
are the "Peace, Love, Linux" company.  However, transports like Myrinet,
SCI, Quads, etc ... are the place to be for local SAN banks.

When NIC's or TOEs support native ipsec, have a CRC32C offload core, and a
few other issues them they will have value.

All the ones I have tested or seen, offload the network stack, do not
support ipsec or handle the CRC32C offload.

Only the MPI fabric cards provide the tools desired.

Cheers,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

