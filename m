Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVBBHKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVBBHKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVBBHKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:10:21 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:51149 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262180AbVBBHKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:10:11 -0500
Date: Wed, 02 Feb 2005 16:10:15 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
References: <1107271039.15652.839.camel@2fwv946.in.ibm.com> <m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050202154926.18D4.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't understand why ELF format is necessary.

I think the only necessary information is "what physical address 
regions are valid to read". This information is necessary for any
sort of dump tools. (and must get it while the system is normal.)
The Eric's /proc/cpumem idea sounds nice to me. 

-- 
Itsuro ODA <oda@valinux.co.jp>

