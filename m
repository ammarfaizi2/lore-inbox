Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422928AbWBCUMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422928AbWBCUMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422927AbWBCUMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:12:55 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:51409 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1422928AbWBCUMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:12:54 -0500
Date: Fri, 3 Feb 2006 21:13:17 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andreas Eriksson <andreas@tpwch.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't enable cpufreq ondemand governor
Message-ID: <20060203201317.GB3965@inferi.kami.home>
Mail-Followup-To: Andreas Eriksson <andreas@tpwch.com>,
	linux-kernel@vger.kernel.org
References: <79052f10602031042p9c5a3d9xf3934a2f0a3073bf@mail.gmail.com> <79052f10602031049m4dfdab3cyce643db486483b70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79052f10602031049m4dfdab3cyce643db486483b70@mail.gmail.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc1-mm4-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 07:49:10PM +0100, Andreas Eriksson wrote:
> The kernels I have tried it with are 2.6.15-1-686 and 2.6.15-ck3 and
> 2.6.15 vanilla, and this happens with all of those.
[...]
> # lsmod | grep speed
> speedstep_ich           4844  0
> speedstep_lib           3972  1 speedstep_ich
> freq_table              4164  1 speedstep_ich

support for ondemand on speedstep-ich has been merged in 2.6.16-rc1
or .15 but using the -mm patchset.

If you don't want to test such kernels you can grab these 2 commits and
apply to 2.6.15 (they'll probably apply cleanly)
<url>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=9a7d82a89a8bf55b112f2a5c3b3f405eb95a4303;hp=1a10760c91c394dfe4adfefeeaf85cd8098c4894</url> 
<url>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=1a10760c91c394dfe4adfefeeaf85cd8098c4894;hp=fc457fa7c0cdbfe96812ba377e508880d600298f</url>                                                                                                                 

hth
-- 
mattia
:wq!
