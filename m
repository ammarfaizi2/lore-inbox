Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFXJJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTFXJJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:09:46 -0400
Received: from komoseva.globalnet.hr ([213.149.32.250]:53515 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S261222AbTFXJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:09:44 -0400
Date: Tue, 24 Jun 2003 10:53:45 +0200
From: Vid Strpic <vms@bofhlet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Promise ATA/133 TX2 IDE Card - Linux 2.4.x driver problem.
Message-ID: <20030624085345.GA20998@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled May  3 2002 20:49:56)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 09:54:17PM -0400, war wrote:
> It may be too early to speculate, however, I have received no spurious
> kernel messages with the first generation Promise ATA/100 board (so far).
> 
> I have another motherboard (MSI), with another Promise ATA/133 board
> (TX2), which also gives this spurious interrupts.
> 
> root@l1:/var/log# grep -i spurious *
> syslog.1:Jun 19 10:08:48 l1 kernel: spurious 8259A interrupt: IRQ7.
> syslog.2:Jun 12 09:33:07 l1 kernel: spurious 8259A interrupt: IRQ7.
> syslog.2:Jun 12 20:03:55 l1 kernel: spurious 8259A interrupt: IRQ7.
> syslog.2:Jun 14 06:42:23 l1 kernel: spurious 8259A interrupt: IRQ7.
> syslog.2:Jun 14 16:12:37 l1 kernel: spurious 8259A interrupt: IRQ7.
> syslog.3:Jun  3 09:27:44 l1 kernel: spurious 8259A interrupt: IRQ7.
> 
> Is there a particular problem with the ATA/133 TX2 boards, this
> error/problem seems to appear with box (that I've used) with this board
> (ATA/133 TX2).
> 
> Also, I've used the ATA/100 in another box for about a 2 year period
> without a single spurious interrupt message.
> 
> This leads me to believe there may be something wrong with the Promise
> ATA/133 TX2 driver for Linux?

Did you enable parallel port (lp) in BIOS, and in the kernel?  In my
experience this could happen if you do 2) and didn't do 1) ....

Promise uses exactly what IRQ?  You didn't told us.  I have 2 boxes with
Promises here (20265, 20267, yes I know older ones) and they use 10 and
12 respectively, without problems ...

-- 
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux lorien 2.4.21 #1 Sat Jun 14 01:23:07 CEST 2003 i586
 10:51:10 up 10 days,  7:32,  8 users,  load average: 0.09, 0.10, 0.14
Where is God?   Right where you left Him.
