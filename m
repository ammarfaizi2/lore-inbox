Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278624AbRJSTaR>; Fri, 19 Oct 2001 15:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278623AbRJSTaI>; Fri, 19 Oct 2001 15:30:08 -0400
Received: from pyongsan.compgen.com ([158.155.0.1]:52490 "EHLO
	panmunjom.compgen.com") by vger.kernel.org with ESMTP
	id <S278624AbRJST3y>; Fri, 19 Oct 2001 15:29:54 -0400
From: Jesse Marlin <jesse.marlin@intec-telecom-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15312.32574.29064.649744@bass.compgen.com>
Date: Fri, 19 Oct 2001 15:30:06 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Abit BP6 | 440 BX UDMA problems
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Reply-To: Jesse.Marlin@intec-telecom-systems.com
X-Face: FbxF/xY<F@|f.|JNG)lOL.T0@>!V>vZ.$FXyN9:*'ZV?cib-\o'fWz2=}_Pb!#.JveZp_T18ZKC5T0RXNN=~_HPOF<X-]))4v@k"zVg(BQ$WN/TLSiy(5.UsehDm6*kK`j]\va%pe}7xUvl/4I@Ce6HVFP/P}Y/|74^~rO-CYcTf6+~VwiO;O0%
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am having a lot of problems with a dual processor celeron Abit BP6
motherboard.  Running lilo does not produce any errors, but after a
reboot I get 'System Halted'.  I originally tried a 2.4.4 SMP kernel,
but have since been trying a non-SMP kernel with the same results.
The boot drive is /dev/hde.  Anytime I boot with a floppy, or CDROM
everything looks okay on the drive, but after I type chroot /mnt
everything starts seg-faulting.

I think the problem is with the UDMA controller which is an integrated
Hightpoint UDMA controller.  The drive is a 10GB Western Digital UDMA66
drive on /dev/hde.  Has anybody experienced this problem before?
Thanks for any help.

--
Jesse Marlin
Intec Telecom Systems
Software Engineer
Main 404-705-2800
Ph 404-705-2912
Fax 404-705-2805
Email jesse.marlin@intec-telecom-systems.com
