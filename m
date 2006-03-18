Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWCRKsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWCRKsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 05:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWCRKsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 05:48:17 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:38357 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750737AbWCRKsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 05:48:16 -0500
Date: Sat, 18 Mar 2006 11:49:17 +0100
From: Mattia Dongili <malattia@linux.it>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
Message-ID: <20060318104916.GB4795@inferi.kami.home>
Mail-Followup-To: Alejandro Bonilla <abonilla@linuxwireless.org>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
References: <20060318082434.M33432@linuxwireless.org> <441BCBAE.2020302@garzik.org> <20060318085954.M66389@linuxwireless.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318085954.M66389@linuxwireless.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc6-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 03:03:40AM -0600, Alejandro Bonilla wrote:
> On Sat, 18 Mar 2006 03:58:22 -0500, Jeff Garzik wrote
> > Alejandro Bonilla wrote:
> > > Hi,
> > > 
> > > I have a few questions about the PM Dual Core and how could it really work
> > > with Linux. Sorry if there are new patches on LKML about any of these things:
> > > 
> > > Could each processor or die, have it's own cpufreq scaling governor?
> > 
> > Sure.  On a laptop, if you don't need dual core power, it makes 
> > sense to turn off the unused core, even.
> > 
> > 	Jeff
> 
> Jeff,
> 
> For some reason, while I was writing this email, I knew you would be the first
> to reply. LOL. Anyway. Does this need new patches sent to LKML or nice
> commands to make this work or any idea if stock cpufreqd should manage the
> cores separatelly? I haven't got that to work on 2.6.15 so far. How flexible

no, currently cpufreqd applies the governor and limits to all available
cpus. Is it really possible to run the 2 cores at different speeds?
I definitely need to upgrade my hardware and get one of those dual core
babies to play with.
Oh, and BTW patches to cpufreqd are welcome in the meantime :)

ciao
-- 
mattia
:wq!
