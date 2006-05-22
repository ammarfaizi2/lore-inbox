Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWEVNrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWEVNrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWEVNrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:47:21 -0400
Received: from palrel12.hp.com ([156.153.255.237]:2968 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1750813AbWEVNrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:47:20 -0400
Date: Mon, 22 May 2006 06:40:40 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4 new perfmon code base, libpfm, and pfmon releases
Message-ID: <20060522134039.GF30750@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released another version of the perfmon new code base package.
This release is still relative to 2.6.17-rc4. This is a cumulative
patch, you don't need the previous patch.

This patch introduces two new major features requested by users:

	- support for IA-32 architected PMU as described by the latest
	  IA-32 architecture manuals. You need at least a Core Duo/Solo
	  processors or newer for this to work.

	- a kernel level interface (kapi) to allow kernel code to call
	  perfmon2 for counting and sampling. Only system-wide measurements
	  are supported. Read comments at the top of perfmon_kapi.c

	- PMD write checkers routines for PMU description tables

I have also released a new version of the user library libpfm: libpfm-3.2-060522.
It includes bug fixes for the architected IA-32 PMU support.

Finally, I have released a new version of the pfmon tool. This new version
includes:
	- support for IA-32 architected PMU (includes Core Duo/Solo processors)
	- bug fixes in the i386 P6/PM support

This version of pfmon-3.2 requires libpfm-3.2-060522.

You can grab the new packages at our web site:

	 http://perfmon2.sf.net

The libpfm and pfmon source code is also available in our CVS repository
accessible from our home page.

Enjoy,

-- 
-Stephane
