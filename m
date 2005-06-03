Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFCE42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFCE42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 00:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFCE42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 00:56:28 -0400
Received: from palrel13.hp.com ([156.153.255.238]:35278 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261190AbVFCE4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 00:56:24 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17055.58094.61614.587435@napali.hpl.hp.com>
Date: Thu, 2 Jun 2005 21:56:14 -0700
To: Keith Owens <kaos@ocs.com.au>
Cc: Rusty Lynch <rusty.lynch@intel.com>, linux-ia64@vger.kernel.org,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       Hien Nguyen <hien@us.ibm.com>
Subject: Re: [RFC] ia64 function return probes 
In-Reply-To: <7459.1117765049@kao2.melbourne.sgi.com>
References: <200506012139.j51LdMhY031546@linux.jf.intel.com>
	<7459.1117765049@kao2.melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 03 Jun 2005 12:17:29 +1000, Keith Owens <kaos@ocs.com.au> said:

  Keith> * arch_prepare_kretprobe() bumps sp by 16 bytes, to account
  Keith> for the saved b0 and ar.pfs.

What if function arguments are being passed on the stack (e.g., more
than 8 scalar arguments)?

	--david
