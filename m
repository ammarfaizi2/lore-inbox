Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWGXQMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWGXQMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGXQMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:12:48 -0400
Received: from mga06.intel.com ([134.134.136.21]:13371 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751321AbWGXQMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:12:47 -0400
X-IronPort-AV: i="4.07,176,1151910000"; 
   d="scan'208"; a="69742727:sNHT126032889381"
Date: Mon, 24 Jul 2006 08:52:01 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: smurf@smurf.noris.de
Cc: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp, akpm@osdl.org
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060724085201.A6517@unix-os.sc.intel.com>
References: <20060722233638.GC27566@kiste.smurf.noris.de> <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060723053755.0aaf9ce0.akpm@osdl.org>; from akpm@osdl.org on Sun, Jul 23, 2006 at 05:37:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2006 at 05:37:55AM -0700, Andrew Morton wrote:
> On Sun, 23 Jul 2006 14:08:29 +0200
> Matthias Urlichs <smurf@smurf.noris.de> wrote:
> > Interestingly, CPU0/1 gets 6000 bogomips while CPU2/3 only reaches 5600 ..?
> > (That happens with both kernels.) I do wonder why, and whether this has any
> > bearing on the current problem.
> 
> I wouldn't expect it to matter, unless the TSCs are running at different
> speeds or something.

Matthias, Can you send us the /proc/cpuinfo output of your system?

>From your config it looks like CPU_FREQ is disabled. Perhaps, can you try with
CPU_FREQ enabled in your config  and see if you see the same issue?

thanks,
suresh
