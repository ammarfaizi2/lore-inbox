Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUHJM0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUHJM0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUHJMYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:24:52 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:30982 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S264585AbUHJMYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:24:44 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org, kernel@nn7.de
Subject: Re: pts/pty problem since 2.6.8-rc2
In-Reply-To: <pan.2004.08.05.07.10.15.718214@nn7.de>
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.8-rc3 (i686))
Message-Id: <E1BuVgG-0000sc-2z@rhn.tartu-labor>
Date: Tue, 10 Aug 2004 15:24:40 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SS> Whenever I boot a kernel of the 2.6.8-* series (also -rc3) I cannot open
SS> up any xterms in X. I first have to lsof /dev/pts and kill all the 1-5
SS> processes listed there. Afterwards xterm etc pops up without problems.

Might be relevant: I saw similar behaviour on a sparc64 at about
2.6.8-rc1 time - I could use only 2 pty's. That was with a kernel with
PREEMPT turned on. The specific kernel gave BUGs and oopses because
PREEMPT is not finished on sparc64 and I thought that the pty problem
was caused by broken PREEMPT. I turned PREEMPT off and haven't seen the
problem since then (running 2.6.8-rc4 currently).

-- 
Meelis Roos
