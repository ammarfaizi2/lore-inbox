Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTKBLKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 06:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTKBLKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 06:10:19 -0500
Received: from [62.233.185.126] ([62.233.185.126]:260 "EHLO
	aclaptop.unregistered.futuro.pl") by vger.kernel.org with ESMTP
	id S261645AbTKBLKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 06:10:15 -0500
From: Szymon =?iso-8859-2?q?Aceda=F1ski?= <accek@poczta.gazeta.pl>
To: "[DaRk]" <darkx@email.it>
Subject: Re: 2.6.0test8 Pentium4 Scaling
Date: Sun, 2 Nov 2003 12:10:07 +0100
User-Agent: KMail/1.5
References: <20031102115224.6f6d6e2e.darkx@email.it>
In-Reply-To: <20031102115224.6f6d6e2e.darkx@email.it>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021210.07474.accek@poczta.gazeta.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 November 2003 11:52, [DaRk] wrote:
> I have enabled cpu scaling feature on my p4 but it doesn't run !!!
> If i enable old /proc/sys/cpu i found a directory 0 and in three files:
> speed
> speed-max
> speed-min
> All set to 0 !
> What i can do ? The test9 resolv this problem ?
> THANKS
>
> Stefano Cadario

1. Make sure, that 'userspace' cpufreq governor is compiled 
(CONFIG_CPU_FREQ_GOV_USERSPACE) and the module cpufreq_userspace is loaded 
(if not compiled in).
2. Refer to Documentation/cpu-freq/user-guide.txt
3. If still doesn't work, try different drivers (p4_clockmod, speedstep, ...)

Cheers
Szymon
