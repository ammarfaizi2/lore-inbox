Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWDLJcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWDLJcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWDLJcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:32:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:41182 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932120AbWDLJcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:32:12 -0400
Message-ID: <443CC915.80205@austin.ibm.com>
Date: Wed, 12 Apr 2006 04:32:05 -0500
From: jschopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Mike Kravetz <mjkravetz@verizon.net>
CC: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       Joel H Schopp <jschopp@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lhms-devel] [PATCH] sparsemem interaction with memory add bug
 fixes
References: <20060412023347.GA9343@w-mikek2.ibm.com>
In-Reply-To: <20060412023347.GA9343@w-mikek2.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> This patch fixes two bugs with the way sparsemem interacts with memory
> add.  They are:
> - memory leak if memmap for section already exists
> - calling alloc_bootmem_node() after boot
> These bugs were discovered and a first cut at the fixes were provided by
> Arnd Bergmann <arnd@arndb.de> and Joel Schopp <jschopp@us.ibm.com>.
> 
> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> 

These fix memory adding spu addresses on cell, among other things.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
