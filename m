Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSJQCiP>; Wed, 16 Oct 2002 22:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSJQCiP>; Wed, 16 Oct 2002 22:38:15 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:9862
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S261644AbSJQCiN>; Wed, 16 Oct 2002 22:38:13 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Andrew Vasquez <praka@san.rr.com>
Cc: linux-kernel@vger.kernel.org, Michael Clark <michael@metaparadigm.com>,
       J Sloan <joe@tmsusa.com>, Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20021017015903.GA20960@praka.local.home>
References: <200210152120.13666.simon.roscic@chello.at>
	 <1034710299.1654.4.camel@localhost.localdomain>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>
	 <3DACEB6E.6050700@metaparadigm.com> <3DACEC85.3020208@tmsusa.com>
	 <3DACF908.70207@metaparadigm.com> <20021016054035.GM15552@clusterfs.com>
	 <20021017015903.GA20960@praka.local.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034822651.27.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 21:44:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 20:59, Andrew Vasquez wrote:
> > Yes, we have seen that ext3 is a stack hog in some cases, and I
> > know there were some fixes in later LVM versions to remove some
> > huge stack allocations.  Arjan also reported stack problems with
> > qla2x00, so it is not a surprise that the combination causes
> > problems.
> > 
> The stack issues were a major problem in the 5.3x series driver.  I
> believe, I can check tomorrow, 5.38.9 (the driver Dell distributes)
> contains fixes for the stack clobbering -- qla2x00-rh1-3 also contain
> the fixes.

Does this mean that 6.01 will NOT work either? What drivers will be
affected? We've already made the move to remove LVM from the mix, but
your comments above give me some doubt as to how definite it is, that
the stack clobbering will be fixed by doing so. 


> IAC, I believe the support tech working with MasterLee had asked 
> for additional information regarding the configuration as well as
> some basic logs.  Ideally we'd like to setup a similiar configuration
> in house and see what's happening...

In-house? Just curious. What can "I" do to know if our configuration
won't get broken, just by removing LVM? TIA.


> --
> Andrew Vasquez | praka@san.rr.com |
> DSS: 0x508316BB, FP: 79BD 4FAC 7E82 FF70 6C2B  7E8B 168F 5529 5083 16BB
