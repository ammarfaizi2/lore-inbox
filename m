Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269406AbUIYUlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269406AbUIYUlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 16:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269411AbUIYUlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 16:41:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34776 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269406AbUIYUlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 16:41:47 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
In-Reply-To: <20040925203841.GB28001@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <1094597710.16954.207.camel@krustophenia.net>
	 <1094598822.16954.219.camel@krustophenia.net>
	 <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>
	 <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu>
	 <1096140366.3504.5.camel@krustophenia.net> <20040925203841.GB28001@elte.hu>
Content-Type: text/plain
Message-Id: <1096144856.3697.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 25 Sep 2004 16:40:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 16:38, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > since your lockups occur under X, could you try to disable DRI/DRM in
> > > your XConfig? Also, would it be possible to connect that box to another
> > > box via a serial line and enable the kernel's serial console via the
> > > 'console=ttyS0,38400 console=tty' boot option and run 'minicom' on that
> > > other box, set the serial line to 38400 baud there too and capture all
> > > kernel messages that occur when the lockups happens? Also enable the NMI
> > > watchdog via nmi_watchdog=1.
> > 
> > Rui brought up an interesting point on the alsa list.  Is this
> > procedure possible at all on a new laptop without a legacy serial
> > port?
> 
> well, netconsole should work.
> 

OK just to save everyone a google search here is the procedure:

http://technocrat.net/article.pl?sid=04/08/14/0236245&mode=thread

Lee


