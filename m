Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVFOSJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFOSJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVFOSJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:09:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24734 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261256AbVFOSI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:08:57 -0400
Subject: Re: Fwd: hpet patches
From: Lee Revell <rlrevell@joe-job.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: George Anzinger <george@mvista.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105061510547ea7d2f0@mail.gmail.com>
References: <88056F38E9E48644A0F562A38C64FB6004FB6BED@scsmsx403.amr.corp.intel.com>
	 <9e47339105061510547ea7d2f0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 14:11:28 -0400
Message-Id: <1118859089.23353.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 13:54 -0400, Jon Smirl wrote:
> It would be more complicated to try and turn it on if it is turned
> off. Mine is turned on at boot even though it has no ACPI entry. A
> routine like this should at least get things started.
> 

I think you are reinventing the wheel, the high res timers patch already
has the necessary voodoo to find and enable the HPET, AFAICT it already
handles your situation (HPET present but missing from ACPI table).

http://sourceforge.net/projects/high-res-timers/

Lee

