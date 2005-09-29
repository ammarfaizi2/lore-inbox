Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVI2OFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVI2OFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVI2OFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:05:46 -0400
Received: from palrel12.hp.com ([156.153.255.237]:17354 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932139AbVI2OFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:05:45 -0400
Date: Wed, 28 Sep 2005 19:07:27 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: new beta of libpfm-3.2 for IA-64/P6/X86-64
Message-ID: <20050929020727.GD5211@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <44BDAFB888F59F408FAE3CC35AB4704102225AA9@orsmsx409> <20050928040218.GB3170@frankl.hpl.hp.com> <20050928103331.GB3808@frankl.hpl.hp.com> <20050929015727.GB5211@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929015727.GB5211@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released a new beta version for libpfm-3.2.
This version of the library includes support for all Itanium processors,
P6 and Pentium M, AMD X86-64.

The release features:
	- updated kernel perfmon headers (2.6.14-rc2-mm1)
	- example cleanups
	- split event tables for generic P6 and Pentium M.
	  Pentium M adds a few events and changes slightly the semantics
	  of some events.
	- a new set of standalone examples which do not need libpfm to compile
	  (examples are setup for P4/Xeon by default)
	- standalone example for P4/Xeon PEBS sampling
	- fix for better handling of edge PERFSEL field on P6.
	- man pages for AMD X86-64 and P6.	

This version requires that you use 2.6.14-rc2-mm1 kernel and the
correspond perfmon-new base patch to run the examples. the kernel
patch is available from the same web site. It is important to note
that the library is not required in order to use the kernel interface.

You can grab this new version at:
	http://www.sf.net/projects/perfmon2

as release: libpfm-3.2-050929

Enjoy,

-- 
-Stephane
