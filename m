Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263888AbTCVWPp>; Sat, 22 Mar 2003 17:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263912AbTCVWPp>; Sat, 22 Mar 2003 17:15:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263888AbTCVWPo>;
	Sat, 22 Mar 2003 17:15:44 -0500
Message-ID: <3E7CE336.4060503@pobox.com>
Date: Sat, 22 Mar 2003 17:27:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] net driver merges
Content-Type: multipart/mixed;
 boundary="------------090408080207060204060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090408080207060204060308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just some small bits that should have been in the last batch.

	Jeff



--------------090408080207060204060308
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 MAINTAINERS                     |    5 +++++
 drivers/net/e1000/e1000_param.c |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/03/22 1.1201)
   [via-rhine] note that Roger is maintainer, in MAINTAINERS

<scott.feldman@intel.com> (03/03/22 1.1200)
   [E1000] Increase default Rx descriptors to 256
   
   * Increase default Rx descriptors from 80 to 256 to give
     better Rx buffering capability in the case of heavy
     Rx load with small packets.


--------------090408080207060204060308--

