Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292946AbSBVSK3>; Fri, 22 Feb 2002 13:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292945AbSBVSKT>; Fri, 22 Feb 2002 13:10:19 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:47493 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292946AbSBVSKL>; Fri, 22 Feb 2002 13:10:11 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202221809.g1MI9n109591@eng2.beaverton.ibm.com>
Subject: 64GB (i386) kernel config + PAGE_OFFSET change
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Feb 2002 10:09:49 -0800 (PST)
Cc: andrea@suse.de
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to boot a 2.4.17 (i386) kernel with 64GB kernel config
and PAGE_OFFSET changed to 3.5 GB (0xE0000000) and it does not boot.

I was wondering why ? I have 8GB on my machine (P-III). I looked 
at Andrea's 3.5 GB user-virtual patch. It does not support 3.5GB 
for 64GB kernel either ? I can't boot even with forcing mem=1G either.

Is there something fundamental here ?

Please let me know.

Thanks,
Badari
