Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUKMU36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUKMU36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 15:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUKMU36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 15:29:58 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:10514 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261188AbUKMU3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 15:29:55 -0500
Date: Sat, 13 Nov 2004 21:29:31 +0100
From: Jedi/Sector One <lkml@pureftpd.org>
To: linux-kernel@vger.kernel.org
Subject: Issues with threads since 2.6.10-rc1-mm4 (was 2.6.10-rc1-mm5 [u])
Message-ID: <20041113202953.GA15117@c9x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  To second Martin Schemmer, it looks like there is indeed something wrong
with threads, probably since 2.6.10-rc1-mm4.

  Apache 2 with the worker (threaded) MPM and NPTL is freezing after some
time with 2.6.10-rc1-mm5 and -mm4. This didn't happen with previous kernels.

  I'm currently trying to revert various patches to find the culprit.

  Best regards,
  
    -Frank.
    
