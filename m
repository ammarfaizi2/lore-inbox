Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUGTLKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUGTLKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbUGTLKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:10:52 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59297 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265230AbUGTLKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:10:51 -0400
MIME-Version: 1.0
Date: Tue, 20 Jul 2004 20:10:47 +0900
Subject: [PATCH] ia64 memory hotplug for hugetlbpages [0/4]
From: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Message-ID: <JO200407202010474.32776875@pst.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Mailer: JsvMail 5.5 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I ported Takahashi-san's memory hotplug patches for hugetlbpages to 
ia64.
The patches are against linux 2.6.7 and work with memory hotplug 
patches which Iwamoto-san, Takahashi-san and Terasawa-san posted.

Restriction:

  * There still remains a problem that patch [15/16] and [16/16] 
    posted by Takahashi-san on July 14 could not be compiled on IA64.
    Now I am considering it.
    At ia64, please don't apply the above patches.

How to apply:

  1) First of all, apply patches which are posted by Takahashi-san
     on July 14 without [15-16/16]. 
　2) Then, aplly all of Terasawa-san's patches.
  3) And, apply this set of patches.

Thank you,
Nobuhiko Yoshida.
