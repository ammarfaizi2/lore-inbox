Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUDKFEO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 01:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUDKFEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 01:04:14 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:32391 "EHLO
	mwinf0902.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262226AbUDKFEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 01:04:12 -0400
Date: Sun, 11 Apr 2004 07:09:30 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       John Levon <levon@movementarian.org>
Subject: Re: [PATCH][2.6] Oprofile, ARM/XScale PMU driver
Message-ID: <20040411070930.GA389@zaniah>
References: <Pine.LNX.4.58.0404072203350.16677@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404072203350.16677@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2004 at 22:16 +0000, Zwane Mwaikambo wrote:

> The following patch adds support for the XScale performance monitoring
> unit to OProfile. It uses not only the performance monitoring counters,
> but also the clock cycle counter (CCNT) allowing for upto 5 usable
> counters.
> 
> The code has been developed and tested on an IOP331 (hardware courtesy of
> Intel) therefore i haven't been able to test it on XScale PMU1 systems.
> Testing on said systems would be appreciated, and if done, please uncomment the
> #define DEBUG line at the top of op_model_xscale.c
> 
> OProfile userspace support has already been committed and should be
> available via CVS.
> 
> Dave, Mohit, i'll send you a tarball of what i have against the -iop tree
> in a seperate email.
> 
> Andrew, please consider for inclusion.

Andrew, I missed this mail, the patch is ok.

http://marc.theaimsgroup.com/?l=linux-kernel&m=108139073518002&q=raw

regards,
Phil
