Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274965AbTHAWk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 18:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274969AbTHAWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 18:40:56 -0400
Received: from main.gmane.org ([80.91.224.249]:64740 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S274965AbTHAWkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 18:40:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wes Felter <wesley@felter.org>
Subject: Re: HELP: cpufreq on HT and/or SMP systems
Date: Fri, 01 Aug 2003 17:36:21 -0500
Message-ID: <pan.2003.08.01.22.36.19.940443@felter.org>
References: <200307312353.54735.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 23:53:54 +0200, Ricardo Galli wrote:

> I have some doubts regarding cpufreq for SMP systems (for developing 
> http://mnm.uib.es/~gallir/cpudyn/).
> 
> If I remember well, I read a while ago that cpufreq didn't work in SMP 
> systems, but reading the docs and kernel/cpufreq.c, it seems there should be 
> any problem? 
> 
> Is it true?
> 
> OTH, I trying it on a P4 HT, and it works, changes in the frequency of one of 
> the "cpu's",  changes both. 

That makes sense, since the CPU only has one clock.

> What happens in the case of several real cpu's? Does it keep the same 
> frequency for every cpu? According to a comment in cpufreq.c, it seems that 
> each cpu might have different frequencies.

AFAIK no SMP systems have voltage/frequency scaling (SpeedStep/PowerNow).
I've heard that ACPI P-states works on SMP, but if it's not doing
voltage/frequency scaling then I don't know what it's doing.

Wes Felter - wesley@felter.org - http://felter.org/wesley/

