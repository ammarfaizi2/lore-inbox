Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVEMUMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVEMUMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVEMUMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:12:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39556 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262529AbVEMUAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:00:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 0/8] ppc64: Introduce Cell/BPA platform, v2
Date: Fri, 13 May 2005 21:31:09 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505132117.37461.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add support for a fifth platform type in the
ppc64 architecture tree. The Broadband Processor Architecture (BPA)
is what machines using the Cell processor should be following
and currently only prototype hardware exists for it.

Except for the last patch, these are functionally the same as
the first version but are updated for 2.6.12-rc4 and contain
changes based on the feedback I got so far.

The first three patches add some infrastructure that is used by
BPA machines but is not really specific to them can could be used
by other new platform types as well.

The next three patches add the actual platform code, which should
be usable for any BPA compatible implementation.

Patch 7 introduces a new file system to make use of the SPUs inside
the processors. This patch is still in a prototype stage and not
intended for merging yet. The final patch adds some user space code
in the Documentation directory that clarifies how to use the file
system. This one should become a separate package at a later point.

	Arnd <><

