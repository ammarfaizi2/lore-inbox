Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759130AbWK3Ifj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759130AbWK3Ifj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759137AbWK3Ifj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:35:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16104 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1759130AbWK3Ifj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:35:39 -0500
Date: Thu, 30 Nov 2006 09:33:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: v2.6.19-rt1, yum/rpm
Message-ID: <20061130083358.GA351@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.19-rt1 tree, which can be downloaded from the 
usual place:

    http://redhat.com/~mingo/realtime-preempt/

merged to v2.6.19 and applied a few more fixes and a KVM update.

to build a 2.6.19-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rt1

the -rt YUM repository for Fedora Core 6 and 5, for architectures x86_64 
and i686 can be activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo

   yum install kernel-rt.x86_64   # on x86_64
   yum install kernel-rt          # on i686

   yum update kernel-rt           # refresh - or enable yum-updatesd

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
