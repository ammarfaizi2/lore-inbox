Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRFIQdR>; Sat, 9 Jun 2001 12:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264376AbRFIQdH>; Sat, 9 Jun 2001 12:33:07 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:46763 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264375AbRFIQc6>; Sat, 9 Jun 2001 12:32:58 -0400
Message-ID: <3B224DCE.7FB8F722@uow.edu.au>
Date: Sun, 10 Jun 2001 02:24:46 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "P.A.M. van Dam" <nucleus@ramoth.xs4all.nl>
CC: "Peter J. Braam" <braam@clusterfilesystem.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ext3 kernel RPMS (2.4.5 & 2.2.19)
In-Reply-To: <Pine.LNX.4.33.0106081522340.1388-100000@lustre.clusterfilesystem.com>,
		<Pine.LNX.4.33.0106081522340.1388-100000@lustre.clusterfilesystem.com>; from Peter J. Braam on Fri, Jun 08, 2001 at 03:23:16PM -0600 <20010609181551.A26422@ladystrange.bluehorizon.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"P.A.M. van Dam" wrote:
> 
> On Fri, Jun 08, 2001 at 03:23:16PM -0600, Peter J. Braam wrote:
> > Hi,
> >
> > Mostly for my own use, I prepared two kernel RPM's with Ext3 in them.
> >
> > Versions:
> > 2.2.19 + 0.0.7a
> > 2.4.5  + 0.0.6
> >
> > PLEASE USE THESE AT YOUR OWN RISK - THEY CONTAIN EXPERIMENTAL FILE SYSTEM
> > CODE.
> > - Peter J. Braam -
> > http://www.clusterfilesystem.com
> 
> Ext3 for 2.4 kernels. Great. It's probably been asked before, but where can I
> find the ext3 patch for the 2.4 kernels?

All the details are at http://www.uow.edu.au/~andrewm/linux/ext3/

Current status is "pretty solid".  Performance is good.
It's basically untested against LVM and RAID.  It can
deadlock under heavy load if you're using quotas.

Avoid those things and you shouldn't have any problems.

Porting it (back) over to -ac and fixing up the quota
problems is basically the next activity on the list.

-
