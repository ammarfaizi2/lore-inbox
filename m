Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264389AbSIVQbP>; Sun, 22 Sep 2002 12:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264403AbSIVQbO>; Sun, 22 Sep 2002 12:31:14 -0400
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:29449 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S264389AbSIVQbO>; Sun, 22 Sep 2002 12:31:14 -0400
Message-ID: <15FDCE057B48784C80836803AE3598D53B88A6@racerx.ixiacom.com>
From: Dan Kegel <dkegel@ixiacom.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Dan Kegel <dkegel@ixiacom.com>
Subject: Enforcing RLIMIT_RSS?
Date: Sun, 22 Sep 2002 09:36:09 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

setrlimit(RLIMIT_AS, ...) can be used to limit the amount
of virtual memory an application uses, but the corresponding
call to limit physical memory, setrlimit(RLIMIT_RSS, ...),
is not implemented in the main tree.

Rik has implemented this feature several times in the past...
here's his 2.4.0 patch,
http://marc.theaimsgroup.com/?l=linux-kernel&m=97811999316400&w=2
and his 2.5.27 patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=102719516200414&w=2

I need this feature on my embedded system, which uses 2.4.17 or so.
Is the 2.4.0 patch the best place to start, or has anyone
updated that patch for a more recent 2.4?

Thanks,
Dan

