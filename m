Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271316AbUJVOvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271316AbUJVOvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271322AbUJVOvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:51:44 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23972
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S271316AbUJVOvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:51:41 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <41791564.20200@cybsft.com>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu>  <4177FADC.6030905@cybsft.com>
	 <1098384016.27089.42.camel@thomas>  <41780687.8030408@cybsft.com>
	 <1098385049.27089.51.camel@thomas>  <41791564.20200@cybsft.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098456218.8955.373.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 16:43:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 16:12, K.R. Foley wrote:
> I am not sure why the tulip driver is being loaded,unloaded,reloaded 
> every time on boot? Anyway, I wanted to check to see if I could generate 
> the above bug on subsequent unloads of the module. I downed the network 
> and the unloaded the tulip module. I did get the message below when 
> unloading the module but no "BUG: atomic counter underflow" message.
> 
> Oct 22 05:43:33 porky kernel: tulip 0000:04:0a.0: Device was removed 
> without properly calling pci_disable_device(). This may need fixing.
> Oct 22 05:43:33 porky net.agent[921]: remove event not handled

Can you please verify this against vanilla 2.6.9 and 2.6.9-mm1 ?

tglx


