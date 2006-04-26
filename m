Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWDZPCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWDZPCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWDZPCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:02:23 -0400
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:17064 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S932463AbWDZPCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:02:22 -0400
Date: Wed, 26 Apr 2006 07:56:36 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: beta of pfmon-3.2 available
Message-ID: <20060426145636.GA6819@frankl.hpl.hp.com>
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

I have finally released the first beta version of pfmon-3.2.
This version is a major update of version 3.0 released
2 years ago. They are many new features which I hope you'll find
useful.

Here are some of the new features:

	- support for perfmon v2.0 AND perfmon v2.2
	- support for all Itanium processors including Montecito
	- support for AMD X86-64 processors
	- support for Intel Pentium M/P6 processors
	- support for event sets and multiplexing (with perfmon v2.2)
	- instruction-based histrogram sampling module format
	- Data-EAR sampling module formats (Itanium only)
	- ability to exclude idle task for system-wide measurements
	- include or exclude interrupted triggered kernel execution for system
	  wide measurements (Itanium and perfmon v2.2 only )
	- support for rum/sum in monitored binaries (Itanium and perfmon v2.2 only)
	- support for cpu sets
	- man page for generic options

For non Itanium processors, the perfmon v2.2 patch must be applied to the kernel.
You need 2.6.17-rc1 or higher.

The Montecito support is currently missing some of the multi-threading features
as well as the cache MESI options for selected events.

You need libpfm-3.2-060421 or newer to compile pfmon. Similarly you may
want to use libunwind and libiberty to enable certain features. Make sure
you look at the README.

Full documentation including processors specific features is online at our
project's web site.

The tarball can be downloaded from our web site at:
	
		http://perfmon2.sf.net

Please test pfmon in your configuration and report any problems to the
perfmon mailing list.

Enjoy,

--
-Stephane
