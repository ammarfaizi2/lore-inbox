Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVBIC3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVBIC3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVBIC25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:28:57 -0500
Received: from gizmo07bw.bigpond.com ([144.140.70.42]:6274 "HELO
	gizmo07bw.bigpond.com") by vger.kernel.org with SMTP
	id S261753AbVBIC0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:26:15 -0500
Message-ID: <420974BC.7080600@bigpond.net.au>
Date: Wed, 09 Feb 2005 13:26:04 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>
Subject: [ANNOUNCE][RFC] PlugSched-3.0 meets CKRM-E17
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch of PlugSched-3.0 against a 2.6.10 kernel with 
ckrm-e17.2610.patch and cpu.ckrm-e17.v10.patch already applied is 
available for download from:

<http://prdownloads.sourceforge.net/cpuse/plugsched-3.0%2Bckrm-E17-for-2.6.10.patch?download>

and a patchset and series file are available in at gzipped tarball at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-3.0%2Bckrm-E17-for-2.6.10.patchset.tar.gz?download>

The model adopted in merging PlugSched with CKRM was to apply the CKRM 
mechanisms as an optional adjunct to each of the schedulers (ingosched, 
staircase, spa_no_frills and zaphod) which can be selected at boot time 
by adding "cpusched=<scheduler name>" to the boot command line.  If the 
CKRM scheduler is included in the build then it can be 
selected/deselected in the usual ways.

PlugSched's version number has been bumped to 3.0 as its interface has 
been modified to increase the ability to share code between schedulers 
as well as integrate with CKRM.

A stand alone version of PlugSched-3.0 will be available in a few days.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
