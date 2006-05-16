Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWEPVcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWEPVcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWEPVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:32:51 -0400
Received: from mga03.intel.com ([143.182.124.21]:1673 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932129AbWEPVcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:32:50 -0400
Message-Id: <4t153d$13ldvv@azsmga001.ch.intel.com>
X-IronPort-AV: i="4.05,134,1146466800"; 
   d="scan'208"; a="37402623:sNHT60826647"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ju, Seokmann'" <Seokmann.Ju@lsil.com>,
       "Chase Venters" <chase.venters@clientec.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: RE: Help: strange messages from kernel on IA64 platform
Date: Tue, 16 May 2006 14:32:49 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcZ5K7zvpC6zXIW4ShqByfERQdSNcAAASG9wAAC4DMA=
In-Reply-To: <890BF3111FB9484E9526987D912B261901BD86@NAMAIL3.ad.lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ju, Seokmann wrote on Tuesday, May 16, 2006 2:13 PM
> Tuesday, May 16, 2006 5:00 PM, Chase Venters wrote:
> > It's a trap, which means the CPU is effectively calling that 
> function.
> O.K, that's why...
> Then, Is there anyway to look up trap table that the CPU has?

By looking at the instruction address that triggered the unaligned
fault, it is coming from a kernel module.

You should look at the runtime symbol table /proc/kallsyms and try
to map that ip into a function.

- Ken
