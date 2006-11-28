Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758367AbWK1NEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758367AbWK1NEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758647AbWK1NEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:04:42 -0500
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:14987 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1758367AbWK1NEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:04:41 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.6
Subject: rt7 sucess Re: 2.6.19-rc6-rt8
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20061127094927.GA7339@elte.hu>
References: <20061127094927.GA7339@elte.hu>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Nov 2006 13:04:38 +0000
Message-Id: <1164719078.8473.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-27 at 10:49 +0100, Ingo Molnar wrote:
> i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 
> the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

Hi, yesterday I have done a "yum -y update" and have installed rt7. 
I test it with success, boot without notsc, don't loose any timer ticket
and found a second new clocksource, tsc. Now I have apci_pm, jiffies and
tsc.
so now for the first time I have a kernel that can boot without boot
options (and without major problems) .

Thanks, 
> 
> I also started tracking Linus' latest -git tree, so all upstream 
> stabilization fixes since -rc6 are included in -rt8 as well.

I don't know how you work with gits, but could be a good idea, if you
split Linus gits of rts patches, I don't know if it is difficult, it is
just an idea.

Thanks,  
--
Sérgio M. B.

