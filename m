Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSEJL2v>; Fri, 10 May 2002 07:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315559AbSEJL2u>; Fri, 10 May 2002 07:28:50 -0400
Received: from surf.viawest.net ([216.87.64.26]:5265 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315042AbSEJL2t>;
	Fri, 10 May 2002 07:28:49 -0400
Date: Fri, 10 May 2002 04:28:19 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] opl3 OSS emulation compile fixes
Message-ID: <20020510112819.GA26247@wizard.com>
In-Reply-To: <20020510062333.GA10020@wizard.com> <Pine.LNX.4.44.0205101146160.6271-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 4:21am  up 3 days, 29 min,  2 users,  load average: 0.01, 0.02, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 11:47:10AM +0200, Zwane Mwaikambo wrote:
> On Thu, 9 May 2002, A Guy Called Tyketto wrote:
> 
> > 
> >         IMHO, this isn't good. I just gave this a run with 2.5.15, and 
> > opl3_oss.c wasn't even touched during compile (either into the kernel or as a 
> > module); it's completely passed over. more than likely when inserted with 
> > modprobe, OSS emulation would fail from functions not being there. I haven't 
> > tried that yet, but this would be my guess..
> 
> OSS emulation? Or OPL3 OSS emulation?
> 

        This is for OPL3 OSS emulation. With your patch applied to 2.5.15, 
opl3_oss.c was not compiled at all, whether into the kernel, or as a module. 
Also, your patch for include/sound/opl3.h did not need to be applied as the 
#ifdef CONFIG_SND_OSSEMUL and #endif lines are already present sound the two 
variables listed.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

