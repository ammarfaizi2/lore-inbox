Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbRGCFDV>; Tue, 3 Jul 2001 01:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265433AbRGCFDM>; Tue, 3 Jul 2001 01:03:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50609 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265222AbRGCFC6>; Tue, 3 Jul 2001 01:02:58 -0400
Date: Sun, 10 Jun 2001 14:45:01 +0530
From: kiran.thirumalai@in.ibm.com
To: linux-kernel@vger.kernel.org
Subject: Validation of memory allocated through kmalloc
Message-ID: <20010610144501.A14342@localhost.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is there some kernel api to validate memory allocated using kmalloc.
Suppose, I allocate some memory using kmalloc and at a later point of execution
I would like to validate if the memory allocated is not possibly freed by some other thread.

Pls suggest a patch/pointers if any.
I also noticed a commented 'CONFIG_DEBUG_MALLOC' config option  (2.4.3 source),
It doesn't seem to be functional.  Any pointers towards the history behind
it would also be helpful.

Thanks in advance,
Kiran

