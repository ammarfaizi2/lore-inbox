Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRIWUBf>; Sun, 23 Sep 2001 16:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272817AbRIWUBY>; Sun, 23 Sep 2001 16:01:24 -0400
Received: from hermes.toad.net ([162.33.130.251]:57813 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S272773AbRIWUBT>;
	Sun, 23 Sep 2001 16:01:19 -0400
Message-ID: <3BAE3F7A.25A717BE@yahoo.co.uk>
Date: Sun, 23 Sep 2001 16:00:58 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Aironet driver version number?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking into the drivers available for the
Cisco Aironet 3[45]x cards and I have found several different
versions.  The three that seem to be the most recent are 
1) the "stock" Linux driver, from the kernel source tree
2) the pcmcia-cs driver, available in the pcmcia-cs package at SourceForge
3) the Cisco driver, available in the Linux driver tarball on the Cisco website

Drivers #2 and #3 have version numbers in them of 1.8 and 1.5.2, respectively.
The stock Linux driver seems a bit more recent than the latter two, yet its
version number is listed as 0.3.  Line 710 of drivers/net/wireless/airo.c:

> static const char version[] = "airo.c 0.3 (Ben Reed & Javier Achirica)";

Is this number inaccurate, or does it belong to a different numbering
scheme?  Or am I wrong and this driver is actually very old?

I would ask the maintainer, but none is listed in linux/MAINTAINERS.
Nevertheless I am bcc:ing the individuals whose e-mail addresses are
given in the source files.

--
Thomas Hood
