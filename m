Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269411AbUIYUu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269411AbUIYUu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 16:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269412AbUIYUu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 16:50:59 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:27528 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S269411AbUIYUu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 16:50:57 -0400
From: Duncan Sands <baldrick@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Date: Sat, 25 Sep 2004 22:50:53 +0200
User-Agent: KMail/1.6.2
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
References: <20040903120957.00665413@mango.fruits.de> <20040925203841.GB28001@elte.hu> <1096144856.3697.6.camel@krustophenia.net>
In-Reply-To: <1096144856.3697.6.camel@krustophenia.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409252250.53703.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 September 2004 22:40, Lee Revell wrote:
> On Sat, 2004-09-25 at 16:38, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > > since your lockups occur under X, could you try to disable DRI/DRM in
> > > > your XConfig? Also, would it be possible to connect that box to another
> > > > box via a serial line and enable the kernel's serial console via the
> > > > 'console=ttyS0,38400 console=tty' boot option and run 'minicom' on that
> > > > other box, set the serial line to 38400 baud there too and capture all
> > > > kernel messages that occur when the lockups happens? Also enable the NMI
> > > > watchdog via nmi_watchdog=1.
> > > 
> > > Rui brought up an interesting point on the alsa list.  Is this
> > > procedure possible at all on a new laptop without a legacy serial
> > > port?
> > 
> > well, netconsole should work.
> > 
> 
> OK just to save everyone a google search here is the procedure:
> 
> http://technocrat.net/article.pl?sid=04/08/14/0236245&mode=thread

You may need this patch:

http://linux.bkbits.net:8080/linux-2.5/cset%4041470590n9GHsFJI2h0NeYTRXiyWMQ?nav=index.html|ChangeSet@-8w

Ciao,

Duncan.
