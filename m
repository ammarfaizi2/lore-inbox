Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422744AbWCXACp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbWCXACp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWCXACp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:02:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422744AbWCXACo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:02:44 -0500
Date: Thu, 23 Mar 2006 16:04:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-mm1
Message-Id: <20060323160426.153fbea9.akpm@osdl.org>
In-Reply-To: <200603232317.50245.Rafal.Wysocki@fuw.edu.pl>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<200603232317.50245.Rafal.Wysocki@fuw.edu.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl> wrote:
>
> On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> 
> On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
> just fine, .config attached):

hm, uniproc x86_64 seems to cause problems sometimes.  I should test it more.

> }-- snip --{
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> time.c: Detected 1795.400 MHz processor.
> disabling early console
> Console: colour dummy device 80x25
> time.c: Lost 103 timer tick(s)! rip 10:start_kernel+0x121/0x220
> last cli 0x0
> last cli caller 0x0
> time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> last cli 0x0
> last cli caller 0x0
> time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0

Hi, John.
