Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310194AbSCAXqZ>; Fri, 1 Mar 2002 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310188AbSCAXqP>; Fri, 1 Mar 2002 18:46:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56783 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310184AbSCAXqB>; Fri, 1 Mar 2002 18:46:01 -0500
Date: Fri, 01 Mar 2002 15:46:14 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: early ioremap not working with 2.4.19-pre1-aa1 ?
Message-ID: <174730000.1015026374@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have code for the NUMA-Q systems that does an ioremap
as the first thing in smp_boot_cpus (ia32 tree). This seems to 
work fine until I install the aa patches ... then it hangs in the 
ioremap.

Has anyone got any idea why this might be? I'd really like to
test out the -aa vm patches on this box ... I can debug it some
more - just looking for an easy answer ;-)

Thanks,

Martin.

