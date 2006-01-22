Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWAVFTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWAVFTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 00:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAVFTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 00:19:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38342 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750754AbWAVFTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 00:19:48 -0500
Date: Sun, 22 Jan 2006 00:19:29 -0500
From: Dave Jones <davej@redhat.com>
To: Thomas Meyer <thomas.mey@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-g3ee68c4: powernow-k7: -ENODEV
Message-ID: <20060122051929.GA6093@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Meyer <thomas.mey@web.de>, linux-kernel@vger.kernel.org
References: <1137862645.8665.11.camel@hotzenplotz.treehouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137862645.8665.11.camel@hotzenplotz.treehouse>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 05:57:25PM +0100, Thomas Meyer wrote:
 > I switched my config from up to smp support with 2 processors.
 > 
 > trying to modprobe powernow-k7 gives me now:
 > "
 > cpufreq-core: trying to register driver powernow-k7
 > cpufreq-core: adding CPU 0
 > cpufreq-core: initialization failed
 > cpufreq-core: no CPU initialized for driver powernow-k7
 > cpufreq-core: unregistering CPU 0
 > "

powernow-k7 doesn't support SMP.
The ubuntu folks tried to make single CPUs work with a SMP kernel,
but it still didn't work out aparently.  The only K7's with powernow
aren't SMP capable anyway iirc.

		Dave

