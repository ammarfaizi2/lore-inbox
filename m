Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTE1CKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 22:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTE1CKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 22:10:18 -0400
Received: from scrye.com ([216.17.180.1]:37038 "HELO scrye.com")
	by vger.kernel.org with SMTP id S264478AbTE1CKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 22:10:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 27 May 2003 20:23:25 -0600
From: Kevin Fenzi <kevin@scrye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@codemonkey.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Subject: Re: Lockups with DRI in APM resume
References: <1054085378.18380.81.camel@sherkaner.pao.digeo.com>
Message-Id: <20030528022328.8BF30F7FA5@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Jeremy" == Jeremy Fitzhardinge <jeremy@goop.org> writes:

Jeremy> If I enable DRI for my Radeon Mobility M6, it crashes when I
Jeremy> resume from an APM suspend.  If I do the suspend while at a
Jeremy> text console, it resumes properly, but then crashes when I
Jeremy> switch to the X server.

Jeremy> I noticed that Andrew has a mention of DRI resume problems in
Jeremy> the must-fix list, so I presume this is an instance of that
Jeremy> problem.  I wonder if there's any patches I can try out, or
Jeremy> anything else I can do to help fix this problem.

Yeah, take a look at: 

http://cpbotha.net/dri_resume.html

Works great here on my Mobility M7 (radeon 7500). 
I can do software suspend even while running 3d apps. 

Jeremy> My hardware is an IBM ThinkPad X31, which is fitted with an
Jeremy> ATI Radeon Mobility M6 LY.  I'm running 2.5.70-mm1 (.config
Jeremy> attached); I'm running RH 9.0, with XFree86 4.3.0.

Jeremy> Thanks, J

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+1B2g3imCezTjY0ERAtUXAJ4mlHbNmT1BXdiquuz6L+EBA7pNlACfXX/a
6lGiSWWk4qpiqtFhVRrAdF8=
=jhvx
-----END PGP SIGNATURE-----
