Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWCYVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWCYVFj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCYVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 16:05:39 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:54297 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751415AbWCYVFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 16:05:38 -0500
Content-Type: multipart/mixed; boundary="===============0036380328=="
MIME-Version: 1.0
Subject: [PATCH 0 of 3] x86-64: Calgary IOMMU
Message-Id: <patchbomb.1143320678@rhun.haifa.ibm.com>
Date: Sat, 25 Mar 2006 23:04:38 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: ak@suse.de
Cc: jdmason@us.ibm.com, mulix@mulix.org, muli@il.ibm.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0036380328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

[Andi, Jon, sorry if you receive multiple copies of this - mercurial's
patchbomb is subtle and quick to anger]

This patchset introduces support for the Calgary IOMMU found on IBM's
high end xSeries servers. It fixes almost all of the issues Andi
raised (details in the individual patches). In particular, X works
fine now - we no longer enable translation on PHB0 by default.

Comments and testing in -mm appreciated!

Cheers,
Muli

--===============0036380328==--
