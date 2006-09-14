Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWINPHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWINPHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWINPHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:07:17 -0400
Received: from mga07.intel.com ([143.182.124.22]:62610 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750704AbWINPHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:07:15 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,165,1157353200"; 
   d="scan'208"; a="116446343:sNHT704618488"
Date: Thu, 14 Sep 2006 08:04:14 -0700
From: Mark Gross <mgross@linux.intel.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Preece Scott-PREECE <scott.preece@motorola.com>,
       pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Message-ID: <20060914150414.GB6008@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20060911082025.GD1898@elf.ucw.cz> <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com> <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912083328.GA19197@elf.ucw.cz> <acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 01:10:24PM +0400, Vitaly Wool wrote:
> Pavel,
> 
> On 9/12/06, Pavel Machek <pavel@ucw.cz> wrote:
> >Can we at least try adding that, before deciding cpufreq is unsuitable
> >and starting new interface? I do not think issues are nearly as big as
> >you think.. (at user<->kernel interface level, anyway; you'll need big
> >changes under the hood).
> 
> who talks about user <-> kernel interface level changes at the moment?!
>

Mostly Pavel is.

There are questions on how to set/get operating points between the
platform and user space, and some questions on one to make the space of
operating points extensible outside of compile time deployment nice.
But these questions aren't the ones I see folks fussing about.

--mgross
