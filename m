Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318484AbSGSJWh>; Fri, 19 Jul 2002 05:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318486AbSGSJWg>; Fri, 19 Jul 2002 05:22:36 -0400
Received: from ns.suse.de ([213.95.15.193]:2832 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318484AbSGSJWf>;
	Fri, 19 Jul 2002 05:22:35 -0400
Date: Fri, 19 Jul 2002 11:25:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: Severe problems with 2.4.19-rc2-aa1 on k6-II
Message-ID: <20020719112528.B15517@oldwotan.suse.de>
References: <Pine.LNX.4.44.0207182027480.3525-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207182027480.3525-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Thu, Jul 18, 2002 at 08:37:42PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 08:37:42PM -0600, Thunder from the hill wrote:
> Hi,
> 
> I'm running 2.4.19-rc2-aa1 on an AMD K6-II 450 (bluemoon).
> The CPU is family 5, model 8, stepping 12. It's constantly at no more 
> than fifty degree Fahrenheit, so it's certainly not a temperature bugset.
> 
> The problems are:
> 
> 1. When booting, I always have to specify hde=none hdf=none ... hdl=none, 
> because otherwise IDE will start probing wildly. (never had that before)
> 2. Mouse and keyboard are both on one port. Now if I load gpm, the whole 
> PS/2 controller gets stuck until I unplug both mouse and keyboard and then 
> re-plug them. It all worked fine ever before.

please try to reproduce with mainline 2.4.19rc2, I don't recall changes from my
part in that area but just in case. thanks,

Andrea
