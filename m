Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRCHPpD>; Thu, 8 Mar 2001 10:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbRCHPoy>; Thu, 8 Mar 2001 10:44:54 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:17864 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129159AbRCHPos>;
	Thu, 8 Mar 2001 10:44:48 -0500
Date: Thu, 8 Mar 2001 16:44:19 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Richard B. Johnson" <johnson@groveland.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3
Message-ID: <20010308164419.C18769@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.21.0103052124250.1132-100000@groveland.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0103052124250.1132-100000@groveland.analogic.com>; from johnson@groveland.analogic.com on Mon, Mar 05, 2001 at 09:35:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 09:35:30PM -0500, Richard B. Johnson wrote:
> 
> Attempts to run linux-2.4.3-pre2 on chaos.analogic.com results
> in **MASSIVE** file-system destruction. I have (had) all SCSI
> disks, using the BusLogic controller.
> 
> There is something **MAJOR** going on BAD, BAD, BAD, even disks
> that were not mounted got trashed.
> 
> This is (was) a 400MHz SMP machine with 256 Mb of RAM. I don't
> know what else to say, since I have nothing to mount. I can
> "get back" but it will take several days. I have to install a
> minimum system then restore everything from tapes.
> 
> I   -- S T R O N G L Y -- suggest that nobody use this kernel with
> a BusLogic SCSI controller until this problem is fixed.
> 
> This is being sent from another machine, not on the list (actually
> from home where I am trying to see what happened -- I brought all
> 4 of my disks home). It looks like some kind of a loop. I have
> a pattern written throughout one of the disks.

Anything new on this? It sounds rather strange considering your
unmounted disks got trashed too, so either it's a problem with the
SCSI subsystem (or the driver; it might be a bug that got triggered
by something else) or some sort of hardware failure.

What kind of pattern was repeated on the disk, by the way? Maybe this
could shed some light unto what happened.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
