Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268449AbTBZAnR>; Tue, 25 Feb 2003 19:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268454AbTBZAnR>; Tue, 25 Feb 2003 19:43:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268449AbTBZAnQ>;
	Tue, 25 Feb 2003 19:43:16 -0500
Subject: [KEXEC][2.5.63] Partially tested patches available
From: Andy Pfiffer <andyp@osdl.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046220814.27557.7.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Feb 2003 16:53:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I have carried forward the kexec patch set to 2.5.63.  I have checked it
on a 1-way system, and 2-way tests are still pending.

There were additional syscall hijinks in the merge to 2.5.63, so anyone
that uses this patch set will need to recompile their kexec tools.

Minor changes to the base patch include the removal of two compile-time
warnings for unused variables.

The patches are available for download from OSDL's patch lifecycle
manageer (PLM):

Patch Stack for 2.5.63:

	kexec base for 2.5.63 (based upon 2.5.54 version)
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1623

	kexec hwfixes for 2.5.63 (based upon 2.5.5[89] version)
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1624

	kexec usemm change (allowed 2-way to work for me):
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1625

	optional change to defconfig to CONFIG_KEXEC=y
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1626

The patches are also available (with matching kexec-tools-1.8) here:
http://www.osdl.org/archive/andyp/kexec/2.5.63/

Andy


