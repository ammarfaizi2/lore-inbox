Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271981AbRIMTjR>; Thu, 13 Sep 2001 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271998AbRIMTjG>; Thu, 13 Sep 2001 15:39:06 -0400
Received: from mail.cb.monarch.net ([24.244.11.6]:53777 "EHLO
	baca.cb.monarch.net") by vger.kernel.org with ESMTP
	id <S271981AbRIMTiv>; Thu, 13 Sep 2001 15:38:51 -0400
Date: Thu, 13 Sep 2001 13:37:26 -0600
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: intermezzo-announce@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [ANNOUNCEMENT] InterMezzo 1.0.5.2
Message-ID: <20010913133726.J1501@lustre.dyn.ca.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just released InterMezzo 1.0.5.2. This is a further test
version ramping up for a stable Linux 2.4 release in 1.0.6.  We now
believe we have fixed most problems in InterMezzo related to Linux
2.4.  This code is released under the GPL.

WHAT IS INTERMEZZO?

InterMezzo is a high availability file system which replicates
directory trees among systems.  It provides disconnected operation,
journal recovery and kernel level write back caching.  It can use the
rsync algorithm for synchronization.  It uses protocols somewhat
similar to Coda's. 

This release includes a kernel rpm (2.4.9-ac5). The 2.4 -ac series
includes intermezzo and this kernel includes a minor extra intermezzo
patch to pure -ac. 

WHAT'S NEW IN THIS RELEASE? 

- it works with ordered data, provided you use the latest ext3
  (Stephen Tweedie)
- replicates ACL's and other extended attributes (requires kernel with
  EA, not packaged) (Shirish Phatak)
- better handling of InterMezzo specific metadata (Phil Schwan and me) 

WHAT'S NEXT? 

- data on demand
- better handling of NFS servers
- DAFS style network packets
- better handling of (false) conflicts for laptop users

DISCLAIMER:

Read the file COPYING in the distribution to see the conditions under
which this software is made available.  Please use this version at
your own risk and exercise care (back up your systems etc).  [With the
2.2.19 kernels fewer problems are known, but a 2.2.19 kernel RPM is
not included.]

WHERE TO GET IT:

You can get sources and rpms from 

ftp://ftp.inter-mezzo.org/pub/intermezzo/current

Documentation is included and available at:
http://www.inter-mezzo.org/

Or get code from the intermezzo project on sourceforge.  Check out the
CVS tag r1_0_5_2.

KNOWN BUGS:

HELP NEEDED:

We could use some help: frequent packaging (there are good packaging
instructions now).  Using, bug reporting and/or fixing is most welcome
too.

Thanks for your interest in InterMezzo, let us know about problems.


- Peter J. Braam -
