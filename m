Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270877AbTHATrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270875AbTHATqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:46:43 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:50111
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270858AbTHAToY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:44:24 -0400
Date: Fri, 1 Aug 2003 15:44:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.6.x net driver merges
Message-ID: <20030801194420.GD3571@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.5

Others may download the patch from

ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test2-netdrvr1.patch.bz2

This will update the following files:

 Documentation/networking/bonding.txt |  343 ++++++++++++++++++++++++-----------
 Documentation/networking/ifenslave.c |    3 
 drivers/net/arcnet/com20020-isa.c    |    2 
 drivers/net/tokenring/ibmtr.c        |    3 
 drivers/net/wireless/airo.c          |  104 +++++++---
 5 files changed, 309 insertions(+), 146 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/01 1.1547.8.10)
   Cset exclude: jgarzik@redhat.com|ChangeSet|20030731201437|53548
   
   My fix was wrong, and, mainline now has a better fix.

<jgarzik@redhat.com> (03/07/31 1.1547.8.9)
   [tokenring ibmtr_cs] fix build, due to missing ibmtr.c build
   
   Note: Better fix is needed.
   
   Contributed by Mike Phillips.

<jgarzik@redhat.com> (03/07/31 1.1547.8.8)
   [arcnet com20020-isa] fix build broken by lack of ->owner

<jgarzik@redhat.com> (03/07/31 1.1547.8.7)
   [netdrvr bonding] fix ifenslave build on ia64
   
   Forward port from 2.4.

<jgarzik@redhat.com> (03/07/31 1.1547.8.6)
   [netdrvr bonding] update docs

<achirica@telefonica.net> (03/07/29 1.1547.8.5)
   [wireless airo] adds support for noise level reporting (if available)

<achirica@telefonica.net> (03/07/29 1.1547.8.4)
   [wireless airo] makes the card passive when entering monitor mode

<achirica@telefonica.net> (03/07/29 1.1547.8.3)
   [wireless airo] eliminate infinite loop
   
   makes sure a possible (never happened, but just in case) infinite
   loop in the transmission code terminates.

<achirica@telefonica.net> (03/07/29 1.1547.8.2)
   [wireless airo] safer shutdown sequence
   
   changes the card shutdown sequence to a safer one

<achirica@telefonica.net> (03/07/29 1.1547.8.1)
   [wireless airo] fix Tx race

