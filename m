Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVFIBGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVFIBGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFIBD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:03:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5098 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261556AbVFIA75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:59:57 -0400
Subject: Re: Dell BIOS and HPET timer support
From: Lee Revell <rlrevell@joe-job.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       lkml <linux-kernel@vger.kernel.org>, Bob Picco <Robert.Picco@hp.com>
In-Reply-To: <9e47339105060817342bdd2dd@mail.gmail.com>
References: <88056F38E9E48644A0F562A38C64FB6004EBD1B0@scsmsx403.amr.corp.intel.com>
	 <9e47339105060817342bdd2dd@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 20:57:52 -0400
Message-Id: <1118278673.6247.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 20:34 -0400, Jon Smirl wrote:
> On 6/8/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> > But, this will not affect normal kernel functioning. This will only
> > affect is someone wants to use /dev/hpet interface.
> 
> I tried the little demo program in Documentation/hpet.txt It seems to work fine.
> 
> Still not sure what 0ns tick signifies. This is an Intel ICH5 chipset.
> 

Check the source, it's self-explanatory.  See hpet_alloc().

Lee

