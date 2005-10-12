Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbVJLQGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVJLQGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVJLQGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:06:34 -0400
Received: from fmr23.intel.com ([143.183.121.15]:55260 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751479AbVJLQGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:06:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: kernel performance update - 2.6.14-rc4
Date: Wed, 12 Oct 2005 09:05:53 -0700
Message-ID: <B05667366EE6204181EABE9C1B1C0EB50877003F@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel performance update - 2.6.14-rc4
Thread-Index: AcXPRtKIcyzuNpoQSkqFnpU7BGJ4XQ==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Oct 2005 16:06:17.0920 (UTC) FILETIME=[E0FC0400:01C5CF46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel performance data for 2.6.14-rc4 is updated at:
http://kernel-perf.sourceforge.net

991 patches went in for rc4 since rc3, all perf. results are
pretty much flat compares to 2.6.14-rc3.  This is probably as
expected since kernel is in the quiet mode.

Result with fileio went up on IPF box, and it is because of a
intermittent bug in the mpt fusion driver. A fix is proposed [*].

We are working on having a sensible configuration for dbench,
all numbers presented on the web site are taken with default
parameters, and it needs to be taken with a grain of salt at
the moment.

	Ken Chen
	Intel Opensource Technology Center


[*] mpt fusion driver performance issue in 2.6.14-rc2
http://marc.theaimsgroup.com/?t=112802043200007&r=1&w=2
