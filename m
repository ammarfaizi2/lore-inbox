Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUEYItb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUEYItb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUEYItb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 04:49:31 -0400
Received: from lum.tdiedrich.de ([193.24.211.71]:56551 "EHLO lum.tdiedrich.de")
	by vger.kernel.org with ESMTP id S264815AbUEYIt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 04:49:29 -0400
Date: Tue, 25 May 2004 10:49:17 +0200
From: Tobias Diedrich <ranma@tdiedrich.de>
To: linux-kernel@vger.kernel.org
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040525084916.GC19699@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@tdiedrich.de>,
	linux-kernel@vger.kernel.org
References: <20040523154859.GC22399@dumbterm.net> <20040523224908.25194.qmail@web40607.mail.yahoo.com> <c8tikk$u6f$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8tikk$u6f$1@gatekeeper.tmr.com>
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://studserv.stud.uni-hannover.de/~ranma/gpg-key
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Virus: No
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.17.5
X-Spam: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> There have been pretty good explanations of this, so I'll just say that 
> it might be that someone with a machine of limited capacity would be 
> able to generate 50fps and not 60fps. In much of Europe the TV flickers 
> at the same frequency as the lights ;-)

Rather the other way around.

768*288*50*2 = 22118400
640*240*60000*2/1001 = 18413586

So the amount of data to process is higher for PAL (in square pixel
resolution).

-- 
Tobias						PGP: http://9ac7e0bc.2ya.com
He said he hadn't had a byte in three days.
I had a short, so I split it with him.

