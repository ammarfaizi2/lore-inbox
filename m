Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVDTArg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDTArg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 20:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDTArg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 20:47:36 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:55518 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261186AbVDTArd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 20:47:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ppc64: prepare for integration of BPA platform
Date: Wed, 20 Apr 2005 01:49:21 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504200149.22063.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds a bit of infrastructure in preparation of
getting the Broadband Processor Architecture (BPA) into the kernel as
a new platform type of ppc64.
BPA is currently used in a single machine from IBM, with others likely
to be added at a later point.

None of these preparation patches are really specific to the
architecture itself. Hopefully, I will be able to send the actual
platform code really soon now.

BPA and pSeries can share some code, mostly because they are both
using rtas. The first two patches are splitting out the common
code from the pSeries_pci implementation into a generic rtas_pci
base.
The nvram and watchdog drivers are pretty generic and are first used
in the new machine.

	Arnd <><

