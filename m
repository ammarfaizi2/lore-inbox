Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271270AbUJVM0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271270AbUJVM0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271269AbUJVMZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:25:27 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:42927 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S271276AbUJVMZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:25:09 -0400
Date: Fri, 22 Oct 2004 14:24:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches.
Message-ID: <20041022122453.GA3720@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
the sacf security exploit went public yesterday, so we shold push
the fix to the BitKeeper tree soon. And guess what I've some other
patches as well ;-)

1) fix sacf local root exploit (CAN-2004-0887)
2) core changes: pid to cr4, cpcmd fixes & missing clobber.
3) cleanup segment load/unload infrastructure.
4) add system control for the debug feature
5) qdio fixes
6) network driver changes

blue skies,
  Martin.
