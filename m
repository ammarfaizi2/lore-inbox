Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWDLOrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWDLOrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWDLOrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:47:01 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:1484 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751174AbWDLOrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:47:00 -0400
Subject: Re: [PATCH] sparsemem interaction with memory add bug fixes
From: Dave Hansen <haveblue@us.ibm.com>
To: Mike Kravetz <mjkravetz@verizon.net>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       Joel H Schopp <jschopp@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060412023347.GA9343@w-mikek2.ibm.com>
References: <20060412023347.GA9343@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 07:46:04 -0700
Message-Id: <1144853164.31255.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 19:33 -0700, Mike Kravetz wrote:
> This patch fixes two bugs with the way sparsemem interacts with memory
> add.  They are:
> - memory leak if memmap for section already exists
> - calling alloc_bootmem_node() after boot
> These bugs were discovered and a first cut at the fixes were provided by
> Arnd Bergmann <arnd@arndb.de> and Joel Schopp <jschopp@us.ibm.com>.

At first glance, these seem fine to me.

Just out of curiosity.  Can these issues be revealed with current code,
or do they only show up with the cell changes?

-- Dave

