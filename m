Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUC3VvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUC3VvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:51:13 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:59152 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261380AbUC3VvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:51:06 -0500
Date: Tue, 30 Mar 2004 22:48:02 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ray Bryant <raybry@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <13395305.1080686882@[192.168.0.89]>
In-Reply-To: <200403302004.i2UK4JF23059@unix-os.sc.intel.com>
References: <200403302004.i2UK4JF23059@unix-os.sc.intel.com>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 30 March 2004 12:04 -0800 "Chen, Kenneth W" <kenneth.w.chen@intel.com> 
wrote:

> I can do:
> 	fd = open("/mnt/htlb/myhtlbfile", O_CREAT|O_RDWR, 0755);
> 	mmap(..., fd, offset);
>
> Accounting didn't happen in this case, (grep Huge /proc/meminfo):
>
> HugePages_Total:    10
> HugePages_Free:      9
> Hugepagesize:    262144 kB
> HugeCommitted_AS:     0 kB

Oooops.  Now I get you.  Thanks for pointing that out.  More work required.

-apw
