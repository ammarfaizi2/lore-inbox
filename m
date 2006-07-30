Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWG3Qtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWG3Qtl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWG3Qtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:49:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30984 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932369AbWG3Qtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:49:40 -0400
Date: Sun, 30 Jul 2006 18:49:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Message-ID: <20060730164938.GA10849@stusta.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607292050.37877.ak@suse.de> <20060729185737.GG26963@stusta.de> <200607292104.18030.ak@suse.de> <20060729191938.GH26963@stusta.de> <200607301614.k6UGEpIL023020@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301614.k6UGEpIL023020@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 12:14:51PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 29 Jul 2006 21:19:38 +0200, Adrian Bunk said:
> 
> > That was never true in Arjan's patches.
> > 
> > The only change is from a gcc version check to a feature check.
> > 
> > In both cases, a gcc 4.1 without the appropriate patch applied will 
> > result in this option not being set.
> 
> What do you get if you have a gcc 4.1.1. that has the stack protector option
> (so a feature check works), but not the fix for gcc PR 28281?

This is handled correctly in both cases.

Please read the patches in this thread for more information.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

