Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUKFIqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUKFIqT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 03:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbUKFIqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 03:46:19 -0500
Received: from calvin.codito.com ([203.199.140.162]:2435 "EHLO
	magrathea.codito.co.in") by vger.kernel.org with ESMTP
	id S261340AbUKFIqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 03:46:15 -0500
From: Amit Shah <amitshah@gmx.net>
Organization: Codito Technologies
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Date: Sat, 6 Nov 2004 14:14:10 +0530
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200411051837.02083.amitshah@gmx.net> <20041105134639.GA14830@elte.hu>
In-Reply-To: <20041105134639.GA14830@elte.hu>
X-GnuPG-Fingerprint: 3001 346D 47C2 E445 EC1B  2EE1 E8FD 8F83 4E56 1092
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411061414.11719.amitshah@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Friday 05 Nov 2004 19:16, Ingo Molnar wrote:
> * Amit Shah <amitshah@gmx.net> wrote:
> > Hi Ingo,
> >
> > I'm trying out the RT preempt patch on a P4 HT machine, I get the
> > following message:
> >
> > e1000_xmit_frame+0x0/0x83b [e1000]
>
> hm, does this happen with -V0.7.13 too? (note that it's against
> 2.6.10-rc1-mm3, a newer -mm tree.)

I had left the machine running overnight; I got a few BUGs and some spinlock 
hold counts.

The message mentioned above about the e1000 xmit frame also keeps appearing, 
but does not result in hangs.

I've uploaded the /var/log/messages file to

 http://amitshah.nav.to/kernel/messages-rt-0.7.13.txt

Please take a look.

>
>  Ingo

Amit.
-- 
Amit Shah
http://amitshah.nav.to/
