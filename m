Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129433AbRAaW2T>; Wed, 31 Jan 2001 17:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbRAaW2J>; Wed, 31 Jan 2001 17:28:09 -0500
Received: from quechua.inka.de ([212.227.14.2]:9538 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129411AbRAaW15>;
	Wed, 31 Jan 2001 17:27:57 -0500
Date: Wed, 31 Jan 2001 23:27:57 +0100
To: linux-kernel@vger.kernel.org
Subject: reiserfs min size (was: [2.4.1] mkreiserfs on loopdevice freezes kernel)
Message-ID: <20010131232757.A23675@lina.inka.de>
In-Reply-To: <20010131052305.A828@lina.inka.de> <Pine.SOL.4.21.0101310923480.29972-100000@green.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.SOL.4.21.0101310923480.29972-100000@green.csi.cam.ac.uk>; from jas88@cam.ac.uk on Wed, Jan 31, 2001 at 09:24:39AM +0000
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 09:24:39AM +0000, James Sutherland wrote:
> 32 megaBLOCK?? How big is it in Mbytes?

Blocksize is 4k, mkreiserfs in my version is telling me it can not generate
partitions smaller than 32M but it is not true, i have to do

dd if=/dev/zero of=/var/loop.img count=32768 size=4096

> You do know reiserfs defaults to
> building a 32 Mbyte journal on the device, I take it?

Yes, I wonder if it is a Error in mkreiserfs to require 128MB.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
