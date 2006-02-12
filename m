Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWBLIpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWBLIpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 03:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWBLIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 03:45:25 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:61586 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932349AbWBLIpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 03:45:24 -0500
Date: Sun, 12 Feb 2006 09:46:18 +0100
From: Mattia Dongili <malattia@linux.it>
To: Nico Golde <nico@ngolde.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting cpu frequency
Message-ID: <20060212084618.GA5439@inferi.kami.home>
Mail-Followup-To: Nico Golde <nico@ngolde.de>, linux-kernel@vger.kernel.org
References: <20060211204733.GA7813@ngolde.de> <20060211213748.GD8337@redhat.com> <20060211214207.GB19045@ngolde.de> <20060211221309.GE8337@redhat.com> <20060211221648.GB12602@ngolde.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211221648.GB12602@ngolde.de>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc2-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 11:16:48PM +0100, Nico Golde wrote:
> * Dave Jones <davej@redhat.com> [2006-02-11 23:15]:
> > On Sat, Feb 11, 2006 at 10:42:07PM +0100, Nico Golde wrote:
> >  > Hallo Dave,
> >  > 
> >  > * Dave Jones <davej@redhat.com> [2006-02-11 22:38]:
> >  > > On Sat, Feb 11, 2006 at 09:47:34PM +0100, Nico Golde wrote:
> >  > >  > Hi,
> >  > >  > at the moment I try to get the current cpu frequency
> >  > >  > P.S. Please CC me, I am not subsribed, thanks
> >  > > 
> >  > > Are you trying to do this from a userspace program ?
> >  > > If so, this isn't going to work.
> >  > 
> >  > Yes I am.
> > 
> > Read it from sysfs or /proc/cpuinfo.
> 
> Thats exactly what I dont wanted to do and thought its 
> possible without reading a file. So it seems to be not, 
> thank you will use sysfs to get the information.
> Regards Nico

there's still libcpufreq from cpufrequtils if you wish some kind of
abstraction over reading a file.

-- 
mattia
:wq!
