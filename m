Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUIHMNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUIHMNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUIHMNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:13:07 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:1733 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269146AbUIHMHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:07:35 -0400
Date: Wed, 8 Sep 2004 14:07:30 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: NFS hangs in 2.4.27
Message-Id: <20040908140730.1a3b77c7.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since a few days I have great NFS problems on six Linux machines. The
execution of "ps aux" shows that processes are hanging for they are
waiting for the completion of uninterruptable NFS I/O and the system
utilization becomes very high.

The hangs occurred since the installation of Kernel 2.4.27 (used 2.4.26
before), so I guess that Kernel 2.4.27 introduces the problems with NFS.
I am not sure about that, but since I reinstalled the old 2.4.26-Kernel
on one of the six computers, that machine works fine.

Has someone else experienced NFS hangs under 2.4.27 so far?

Kind regards
  Christoph Pleger
