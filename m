Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTL2Iqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 03:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTL2Iqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 03:46:36 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:11436 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262960AbTL2Iqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 03:46:34 -0500
Date: Mon, 29 Dec 2003 00:11:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: robe@amd.co.at
Subject: [Bug 1760] New: GPF when using fusion mpt with amd64	and 64bit kernel 
Message-ID: <6260000.1072685468@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1760

           Summary: GPF when using fusion mpt with amd64 and 64bit kernel
    Kernel Version: 2.6.0
            Status: NEW
          Severity: blocking
             Owner: andmike@us.ibm.com
         Submitter: robe@amd.co.at


Distribution: gentoo, debian testing

Hardware Environment: Tyan Transport GX28 Dual Opteron Barebone 
(http://www.tyan.com/products/html/gx28b2880t1s.html)

Problem Description: 

It seems as if the Fusion MPT driver has problems when being used in a 64-Bit 
environments. Please see the following "screen shots" for the bug outputs:

Gentoo-Livecd from 21.12.03:
http://amd.co.at/images/kernelstuff/gentoo.jpg

Vanilla 2.6.0 compiled in debian amd64 environment:
http://amd.co.at/images/kernelstuff/vanilla.jpg

Steps to reproduce:
Boot amd64 64bit kernel, access device which is attached to fusion mpt based 
scsi controller.


