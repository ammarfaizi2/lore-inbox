Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269409AbUIYUhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbUIYUhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 16:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269410AbUIYUhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 16:37:04 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:16066 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269409AbUIYUhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 16:37:01 -0400
Date: Sat, 25 Sep 2004 22:38:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040925203841.GB28001@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <1094597710.16954.207.camel@krustophenia.net> <1094598822.16954.219.camel@krustophenia.net> <32930.192.168.1.5.1094601493.squirrel@192.168.1.5> <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu> <1096140366.3504.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096140366.3504.5.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > since your lockups occur under X, could you try to disable DRI/DRM in
> > your XConfig? Also, would it be possible to connect that box to another
> > box via a serial line and enable the kernel's serial console via the
> > 'console=ttyS0,38400 console=tty' boot option and run 'minicom' on that
> > other box, set the serial line to 38400 baud there too and capture all
> > kernel messages that occur when the lockups happens? Also enable the NMI
> > watchdog via nmi_watchdog=1.
> 
> Rui brought up an interesting point on the alsa list.  Is this
> procedure possible at all on a new laptop without a legacy serial
> port?

well, netconsole should work.

	Ingo
