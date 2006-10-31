Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423463AbWJaPFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423463AbWJaPFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423465AbWJaPFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:05:09 -0500
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:44948 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1423463AbWJaPFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:05:07 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <20061030184155.A3790@unix-os.sc.intel.com>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
	 <20061030184155.A3790@unix-os.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 31 Oct 2006 15:05:04 +0000
Message-Id: <1162307104.24095.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 18:41 -0800, Siddha, Suresh B wrote:
> On Tue, Oct 31, 2006 at 12:03:28AM +0000, Sergio Monteiro Basto wrote:
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> 
> Is this the reason why you are saying your system has unsynchronized TSC?

yes 

> Some where in this thread, you mentioned that Lost ticks happen even
> when you use  "notsc"

yes, with news kernels 2.6.19-rcx

> 
> This sounds to me as a different problem. Can you send us the output
> of /proc/interrupts?

of which kernel ?
I am not at home .. 
but I have here /proc/interrupts from one 2.6.16 
http://bugzilla.kernel.org/attachment.cgi?id=7927&action=view
from my bug 
http://bugzilla.kernel.org/show_bug.cgi?id=6419

Tonight I can attach on bugzilla bug#6419, /proc/interrupts from one
kernel 2.6.18 and from one kernel 2.6.19-rc4 

BTW: those kernels are for x86_64 arch, I haven't try, yet, i386, but
maybe will be my next test. 

Thanks, 
--
Sérgio M. B.
> 
> thanks,
> suresh

