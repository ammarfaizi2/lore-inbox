Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWJVUpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWJVUpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWJVUpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:45:49 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:55999 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751469AbWJVUpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:45:47 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Avi Kivity <avi@qumranet.com>, Arnd Bergmann <arnd@arndb.de>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
X-Message-Flag: Warning: May contain useful information
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de>
	<453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de>
	<453BA3E9.4050907@qumranet.com> <20061022175609.GA28152@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 22 Oct 2006 13:45:45 -0700
In-Reply-To: <20061022175609.GA28152@infradead.org> (Christoph Hellwig's message of "Sun, 22 Oct 2006 18:56:10 +0100")
Message-ID: <adapsckhyfa.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Oct 2006 20:45:46.0325 (UTC) FILETIME=[0CA3D050:01C6F61B]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Again, what's the point?  All cpus shipped by Intel and AMD that have
 > hardware virtualization extensions also support the 64bit mode.  Given
 > that I don't see any point for supporting a 32bit host.

Actually there are 32-bit only Intel CPUs with hardware virtualization --
in fact my laptop has one: "Core Duo processor Low Voltage L2400".

http://www.intel.com/products/processor_number/proc_info_table.pdf
shows quite a few models with virtualization but without EM64T.

 - R.
