Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVAZAYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVAZAYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVAZAXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:23:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:5104 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262261AbVAZAXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:23:22 -0500
Subject: [RFC][PATCH 0/5] consolidate i386 NUMA init code
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 16:23:05 -0800
Message-Id: <1106698985.6093.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following five patches reorganize and consolidate some of the i386
NUMA/discontigmem code.  They grew out of some observations as we
produced the memory hotplug patches.

Only the first one is really necessary, as it makes the implementation
of one of the hotplug components much simpler and smaller.  2 and 3 came
from just looking at the effects on the code after 1.

4 and 5 aren't absolutely required for hotplug either, but do allow
sharing a bunch of code between the normal boot-time init and hotplug
cases.  

These are all on top of 2.6.11-rc2-mm1.

-- Dave

