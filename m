Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275069AbTHGFR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275068AbTHGFR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:17:57 -0400
Received: from [66.212.224.118] ([66.212.224.118]:22799 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275069AbTHGFRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:17:54 -0400
Date: Thu, 7 Aug 2003 01:06:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: john stultz <johnstul@us.ibm.com>
Cc: Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@web.de>,
       lkml <linux-kernel@vger.kernel.org>, Mark Haverkamp <markh@osdl.org>,
       Dave Jones <davej@suse.de>
Subject: Re: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
In-Reply-To: <1060201495.10732.75.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0308070057510.9517@montezuma.mastecende.com>
References: <200308061052.18550.Mathias.Froehlich@web.de> 
 <1060190104.10732.52.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.53.0308061423080.7244@montezuma.mastecende.com>
 <1060201495.10732.75.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, john stultz wrote:

> On Wed, 2003-08-06 at 11:31, Zwane Mwaikambo wrote:
> > The intel manual (10-36 Memory Cache Control - vol3) actually recommends 
> > the following procedure I was a bit anal about explicitely setting and 
> > clearing flags and used the specific TLB flush via cr3->reg->cr3. John 
> > could you give this a spin on your afflicted systems?
> 
> I'm not quite sure I follow. Really I've never looked at the mtrr code
> before, so forgive my daftness.  I just found a deadlock that was
> locking my box caused by the synchronization between ipi_handler() and
> set_mtrr() (which Mark's patch seems to properly fix). 
> 
> How does this change affect the deadlock? Is this just a separate issue?
> thanks

Mostly seperate issue, but seeing as we where there, there is a slight 
deviation from recommended procedure. Sorry about that, you may ignore it.

Thanks
	Zwane
-- 
function.linuxpower.ca
