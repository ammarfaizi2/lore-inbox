Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267947AbTBRRUE>; Tue, 18 Feb 2003 12:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTBRRSb>; Tue, 18 Feb 2003 12:18:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267937AbTBRRP2>;
	Tue, 18 Feb 2003 12:15:28 -0500
Subject: [Fastboot] [KEXEC][2.5.61][2.5.62] Untested patches available
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <1044918007.1705.22.camel@andyp.pdx.osdl.net>
References: <1044918007.1705.22.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1045589128.23988.34.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Feb 2003 09:25:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I have carried forward the kexec patch set to 2.5.61 and 2.5.62.
Other than basic compile testing, I have not yet finished kicking the
tires on these patches.

There were some syscall hijinks in the merge up to 2.5.61 and in 2.5.62,
so you may need to edit/recompile the kexec tools for either of these to
work.

New in this set is a small change taken from the ppc64 tree via Suparna
Bhattacharya that made kexec on 2.5.60 work for me on a 2-way x86
system.

(Suparna: I have not yet tried your newer version of hwfixes).

The patches are available for download from OSDL's patch lifecycle
manager (PLM):

Patch Stack for 2.5.62:

	kexec base for 2.5.62 (based upon the version for 2.5.54):
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1560

	kexec hwfixes for 2.5.62 (based upon the version for 2.5.5[89])
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1561

	kexec usemm change (allowed 2-way to work for me):
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1562

	optional change to defconfig (I used this for PLM-based builds)
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1564

Patch Stack for 2.5.61:

	kexec base for 2.5.61 (based upon the version for 2.5.54):
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1556

	kexec hwfixes for 2.5.61 (based upon the version for 2.5.5[89])
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1557

	kexec usemm change (allowed 2-way to work for me):
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1558

	optional change to defconfig (I used this for PLM-based builds)
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1559

Regards,
Andy



