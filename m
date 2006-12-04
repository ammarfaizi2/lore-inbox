Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937134AbWLDQtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937134AbWLDQtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937131AbWLDQtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:49:10 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:53012 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936880AbWLDQtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:49:06 -0500
Date: Mon, 4 Dec 2006 08:46:44 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.19 new perfmon code base + libpfm + pfmon
Message-ID: <20061204164644.GO31914@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released another version of the perfmon new code base packages.

There is no major updates in this version compared to 061127. This is 
a convenience release so that people can use plain 2.6.19.

The perfmon2 kernel changes are:
	- fix UP exit bug in system-wide mode where the active context
	  accounting was done incorrectly.
	- MIPS update to correct register hardware addresses (Phil Mucci)

I have also released a new libpfm, libpfm-3.2-061204 with the
following changes:
	- updated MIPS processor detection code

Also a new version of pfmon, pfmon-3.2-061204 with the following changes:
	- fix various perfmon v2.0 compatibility bugs for IA-64
	- fortify return values for read() (will Cohen)
	
Both libpfm and pfmon releases work with kernel-patch 061127 or 061204.

You can grab the new packages at our web site:

	 http://perfmon2.sf.net

Enjoy,

-- 
-Stephane
