Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUJCMkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUJCMkO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUJCMkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:40:14 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:51359 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267880AbUJCMkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 08:40:10 -0400
Date: Sun, 3 Oct 2004 14:41:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2
Message-ID: <20041003124146.GA20260@elte.hu>
References: <2Jw9b-52b-13@gated-at.bofh.it> <20040929222619.5da3f207.khali@linux-fr.org> <20041001184431.4e0c6ba5.akpm@osdl.org> <20041002090125.302fff71.khali@linux-fr.org> <20041003111458.GA15390@elte.hu> <20041003141140.319039de.khali@linux-fr.org> <20041003121645.GA19580@elte.hu> <20041003143549.12c7fdcc.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041003143549.12c7fdcc.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jean Delvare <khali@linux-fr.org> wrote:

> OK, I understand now. Both affected systems are running Slackware 9.1,
> which may be a bit old (October 2003), but 2.6-ready, so I am using
> bleeding edge 2.6 kernels, with no problems (well until a few days ago
> ;))

i didnt mean to imply anything negative about Slackware - it's a
borderline date of release when it could have been 2.6-ready (although
2.6 was not relased yet at that date ;) but not have new gcc yet. It is
a full and primary requirement of the kernel to run !pt_gnu_stack
binaries too - it just wasnt that well tested for a complete distro, for
the reasons i mentioned.

	Ingo
