Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317358AbSFCKeJ>; Mon, 3 Jun 2002 06:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317357AbSFCKdo>; Mon, 3 Jun 2002 06:33:44 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:47783 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317356AbSFCKdh>; Mon, 3 Jun 2002 06:33:37 -0400
Subject: [Announce[ Dynamic Probes v3.6
To: linux-kernel@vger.kernel.org
Cc: dprobes@www-124.southbury.usf.ibm.com, ak@suse.de, hanrahat@us.ibm.com,
        Richard_J_Moore/UK/IBM%IBMGB%IBMAU <richardj_moore@uk.ibm.com>
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OFCB7BF3A0.6D0E0894-ON65256BCD.00384418-65256BCD.003AC4FE@in.ibm.com>
From: "S Vamsikrishna" <vamsi_krishna@in.ibm.com>
Date: Mon, 3 Jun 2002 16:00:49 +0530
X-MIMETrack: Serialize by Router on d23m0067/23/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/06/2002 04:00:28 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Probes v3.6 is released.

Dynamic Probes is a generic and pervasive debugging facility that will
operate under the most extreme software conditions such as debugging a
deep rooted operating system problem in a live environment.

Highlights of v3.6 include a new DProbes C Compiler that allows you to
write probe programs in a C-like language and integrated support for
S/390 platform. Avaiblabe at the project website:

http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes/

Changelog:
- New with this version is the DProbes High Level Language compiler
  dpcc which enables you to write RPN probe programs in a
  C-like language. Checkout dpcc/ dir in the tarball for details.
- DProbes for s390 integrated into this package
- new patches/ directory containing all the kernel patches.
- kernel patch is split into multiple files. We now have a patch with
  all arch-independent mods in a core patch, along with a patch
  for each architecture (currently i386 and s390). You need to apply
  the core patch first and then the arch-specific patch for your
  architecture.
- Make RPN IO instruction related code i386-specific as s390 does not
  implement io*().
- Up JMP_MAX to 65535, dpcc needs this.
- Sync up kernel hooks code with version 1.6.
- Documentation updates to for s/390 arch.

Regards.. Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi_krishna@in.ibm.com

