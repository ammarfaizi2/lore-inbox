Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUCLAXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUCLAXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:23:55 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:5111 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261854AbUCLAXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:23:54 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Fri, 12 Mar 2004 00:22:13 +0000
User-Agent: KMail/1.6
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com> <200403111819.25819.richard@redline.org.uk> <Pine.LNX.4.58.0403111715560.29087@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403111715560.29087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403120022.13534.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 22:17, Zwane Mwaikambo wrote:
> On Thu, 11 Mar 2004, Richard Browning wrote:
> > I've now updated the BIOS to the latest version available on Asus' site.
> > The crash occurs even earlier - during bootup this time. Exactly:
> >
> > CPU2: Machine Check Exception: 000.0004
> > CPU3: Machine Check Exception: 000.0004
> > Bank 0: a20000008c010400Bank0: a20000008c010400
> > Kernel Panic: CPU context corrupt
> > In idle task - not syncing
> >
> > Again, disabling hyperthreading allows the system to operate normally.
>
> For my own curiosity, does switching the processors around do anything?
> Those MCEs look confined to the non bootstrap processor package.

Switched CPUs. This time I get the following:

CPU3: Machine Check Exception: 000.0004
CPU2: Machine Check Exception: 000.0004
Bank 0: a20000008c010400
Kernel Panic: CPU context corrupt
In idle task - not syncing

Note that the CPU# designations are swapped and that there's only one Bank 0: 
message. Is this significant?

R
