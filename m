Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbULMSJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbULMSJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 13:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbULMSJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 13:09:23 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:24632 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261306AbULMSJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:09:18 -0500
Cc: openib-general@openib.org
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Mon, 13 Dec 2004 10:09:16 -0800
Message-Id: <20041213109.xPBcb5yOtGKuT24L@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v3][0/21] Initial submission of InfiniBand patches for review
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 13 Dec 2004 18:09:17.0521 (UTC) FILETIME=[DC678410:01C4E13E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches is the latest version of the OpenIB
InfiniBand drivers.  We believe that this version is suitable for
merging when 2.6.11 opens (or into -mm immediately), although of
course we are willing to go through as many more iterations as
required to fix any remaining issues.

We appreciate all of the excellent feedback we received for our
previous posting, and we believe we have addressed all of the problems
that were identified.  We did not intentionally ignore any issues --
if we did not address some of your comments, please rest assured that
it was an error on our part.

Based on the discussion on cleaning up kernel headers, we have left
our .h files under drivers/infiniband/include.  None of these .h files
are used outside of drivers/infiniband, so it seems that it is better
not to add them to the global include/ namespace.

Thanks,
  Roland Dreier
  OpenIB Alliance
  www.openib.org

