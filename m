Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVD1IgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVD1IgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVD1IgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:36:21 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:23037 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261969AbVD1IOJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:14:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ppc64: Introduce BPA platform
Date: Thu, 28 Apr 2005 09:54:00 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504190318.32556.arnd@arndb.de>
X-KMail-CryptoFormat: 15
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add support for a fifth platform type in the
ppc64 architecture tree. The Broadband Processor Architecture (BPA)
is currently used in a single machine from IBM, with others likely
to be added at a later point.

I already sent preparation patches before, these need to be applied
on top of them.
The first three patches add the actual platform code, which should
be usable for any BPA compatible implementation.

The final patch introduces a new file system to make use of the
SPUs inside the processors. This patch is still in a prototype stage
and not intended for merging yet.

	Arnd <><

