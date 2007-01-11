Return-Path: <linux-kernel-owner+w=401wt.eu-S965224AbXAKFN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbXAKFN1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 00:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbXAKFN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 00:13:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3466 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965241AbXAKFNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 00:13:25 -0500
Date: Thu, 11 Jan 2007 06:13:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Henrique de Moraes Holschuh <hmh@hmh.eng.br>, len.brown@intel.com,
       linux-acpi@vger.kernel.org,
       Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>,
       "Vladimir V. Saveliev" <vs@namesys.com>, reiserfs-dev@namesys.com,
       Sami Farin <7atbggg02@sneakemail.com>, David Chinner <dgc@sgi.com>,
       xfs-masters@oss.sgi.com, Brice Goglin <brice@myri.com>,
       Robert Hancock <hancockr@shaw.ca>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, Roland Dreier <rdreier@cisco.com>,
       Avi Kivity <avi@qumranet.com>, kvm-devel@lists.sourceforge.net
Subject: 2.6.20-rc4: known regressions with patches (v3)
Message-ID: <20070111051329.GB21724@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ibm-acpi: bay support disabled
References : http://lkml.org/lkml/2007/1/9/242
Submitter  : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Caused-By  : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
             commit 2df910b4c3edcce9a0c12394db6f5f4a6e69c712
Handled-By : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Patch      : http://lkml.org/lkml/2007/1/9/242
Status     : patch to revert the commit available


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs)
References : http://lkml.org/lkml/2007/1/7/117
Submitter  : Malte Schröder <MalteSch@gmx.de>
Handled-By : Vladimir V. Saveliev <vs@namesys.com>
Patch      : http://lkml.org/lkml/2007/1/10/202
Status     : patch available


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
Submitter  : Sami Farin <7atbggg02@sneakemail.com>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/1/7/201
Status     : patch available


Subject    : nVidia CK804 chipset: not detecting HT MSI capabilities
References : http://lkml.org/lkml/2007/1/5/215
Submitter  : Brice Goglin <brice@myri.com>
             Robert Hancock <hancockr@shaw.ca>
Handled-By : Brice Goglin <brice@myri.com>
Patch      : http://lkml.org/lkml/2007/1/5/215
Status     : patch available


Subject    : KVM: guest crash
References : http://lkml.org/lkml/2007/1/8/163
Submitter  : Roland Dreier <rdreier@cisco.com>
Handled-By : Avi Kivity <avi@qumranet.com>
Patch      : http://lkml.org/lkml/2007/1/9/280
Status     : patch available


