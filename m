Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbTE0OvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTE0OvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:51:04 -0400
Received: from nn7.excitenetwork.com ([207.159.120.61]:21272 "EHLO
	xmxpita.excite.com") by vger.kernel.org with ESMTP id S263657AbTE0OvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:51:02 -0400
To: linux-kernel@vger.kernel.org
Subject: RE:Linux 2.4.21-rc4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 4d4a2fc725996ee72cd2eb427b7ca2e1
Reply-To: paragw@excite.com
From: "Parag Warudkar" <paragw@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: marcelo@conectiva.com.br
Message-Id: <20030527150416.408A03CE6@xmxpita.excite.com>
Date: Tue, 27 May 2003 11:04:16 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

[Noting that there is no changelog pertaining to PCMCIA in rc4] PCMCIA is still not usable for me with stock 2.4.21-rc4 kernel.
I can reproduce a complete hang (no response whatsoever) with rc3 everytime I boot with the PCMCIA service enabled.

I am patching it with latest ACPI patch from Sourceforge, but turning ACPI off doesn't make a difference.

Of course I can try vendor kernels or -ac, but is PCMCIA something with a priority low enough for such a major bug to be ignored?

(See my earlier post [2.4.21-rc3 PCMCIA serial_cs.c Reproducible Hang] - for complete details)

If anyone is interested I am ready to provide all details and experiment further.

Parag

Hi, 

Here goes -rc4, hopefully fixing all problems now. 

rc5 will only be released in case of REALLY bad problems. 

Please test it extensively. 

Summary of changes from v2.4.21-rc3 to v2.4.21-rc4 
============================================ 

<minyard@acm.org>: 
  o IPMI fixes 

<viro@parcelfarce.linux.theplanet.co.uk>: 
  o Fix writing to /dev/console 

Barry K. Nathan <barryn@pobox.com>: 
  o Correctly fix the ioperm issue 

Benjamin Herrenschmidt <benh@kernel.crashing.org>: 
  o Update ide/ppc/pmac.c 
  o Fix controlfb build with gcc3.3 
  o PPC32 Fix warning with ndelay (with patch !) 

Marcelo Tosatti <marcelo@freak.distro.conectiva>: 
  o Changed EXTRAVERSION to -rc4 
  o Cset exclude: c-d.hailfinger.kernel.2003@gmx.net|ChangeSet|20030526190224|33683 
  o Really fix xconfig breakage 

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
