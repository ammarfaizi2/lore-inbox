Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270787AbTGNUXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270794AbTGNUVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:21:38 -0400
Received: from qpirg-righttomove-k0.Concordia.CA ([132.205.87.179]:23936 "EHLO
	smtp.rtm-lvl.org") by vger.kernel.org with ESMTP id S270833AbTGNUSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:18:13 -0400
Date: Mon, 14 Jul 2003 16:32:59 -0400
From: Marc Heckmann <mh@nadir.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 smp: system lockup
Message-ID: <20030714203258.GA6959@nadir.org>
References: <20030712171001.GA18262@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712171001.GA18262@nadir.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

just realised that I forgot to run ksymoops over the sysrq+t output.

the resolved output is attached. (it's big, so I had to gzip it.i sorry ). 

Also, I was wondering if the deadlock I encountered might whave been the 
IO-pausing under SMP systems that people have been talking about? 

thanks in advance.

-m

On Sat, Jul 12, 2003 at 01:10:02PM -0400, Marc Heckmann wrote:
> Hi,
> 
> I recently experienced a lockup on an SMP 2.4.21 kernel (vanilla).
> 
> The machine was under very heavy IO at the time. (a full backup was in
> progress). gzipped Alt+sysrq+t output is attached. I forgot
> Alt+sysrq+P unfortunatly.
> 
> iptables was still functional, it still responded to pings, but
> everything else was locked up. obviously sysrq was still working. I
> managed to reboot it with sysrq+b over the serial line.
> 
> the machine has been in production for a while and has run in the past
> for almost 2 months w/o any problems, so I don't believe it's hardware
> related.
> 
> A similar lockup happened once with the redhat 2.4.20-13.9 kernel. I
> blamed that on all the extra patches present and switched to 2.4.21
> hoping that it would alleviate the problem.
> 
> PS: I'm not an linux-kernel so please CC me directly.
> 
> -m


