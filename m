Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbWAMMJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWAMMJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWAMMJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:09:35 -0500
Received: from palakse.guam.net ([202.128.0.38]:25728 "EHLO palakse.guam.net")
	by vger.kernel.org with ESMTP id S932712AbWAMMJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:09:35 -0500
From: "Michael D. Setzer II" <mikes@kuentos.guam.net>
To: linux-kernel@vger.kernel.org
Date: Fri, 13 Jan 2006 22:09:51 +1000
MIME-Version: 1.0
Subject: Problem getting PCMCIA to compile in Kernel. 
Message-ID: <43C8252F.6483.C6B2A8@mikes.kuentos.guam.net>
X-PM-Encryptor: QDPGP, 4
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've tried to set the PCMCIA options to Y in the kernel build, but get a 
message that something else is build as a modual, so these can not be 
changed to y. I went to the .config file and replaced every =m to =y, and then 
ran make. The kernel then was built with no problem, but it reset all these 
option back to =m.

CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m
CONFIG_I2C_STUB=m

I build kernels for G4L, and build everything directly into the kernel, but 
these do not seem to work, and I don't have an ideal why, since everything 
else is built in. So what am I missing. This is the 2.6.15 kernel. 

Thanks.

+----------------------------------------------------------+
  Michael D. Setzer II -  Computer Science Instructor      
  Guam Community College  Computer Center                  
  mailto:mikes@kuentos.guam.net                            
  mailto:msetzerii@gmail.com
  http://www.guam.net/home/mikes
  Guam - Where America's Day Begins                        
+----------------------------------------------------------+

http://setiathome.berkeley.edu
Number of Seti Units Returned:  19,471
Processing time:  32 years, 290 days, 12 hours, 58 minutes
(Total Hours: 287,489)


BOINC Seti@Home Total Credits 264500.664176 


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8 -- QDPGP 2.61c
Comment: http://community.wow.net/grt/qdpgp.html

iQA+AwUBQ8cL8SzGQcr/2AKZEQKFsACYrTbOYFUCiiXUp4gSHLMCM2ODNACg3QcP
nIbkp5rVOhFHrMIdspQA4AY=
=gLiv
-----END PGP SIGNATURE-----

