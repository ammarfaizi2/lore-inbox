Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVEaRLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVEaRLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVEaRLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:11:19 -0400
Received: from fmr24.intel.com ([143.183.121.16]:46271 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261531AbVEaRDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:03:12 -0400
Date: Tue, 31 May 2005 10:02:52 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>, jeremy@goop.org
Subject: Re: CPUFREQ/speedstep on Intel 955X chipset based system
Message-ID: <20050531100252.A11952@unix-os.sc.intel.com>
References: <429A07EF.6090905@gmail.com> <429A14C3.20604@tiscali.de> <429A39BF.3020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <429A39BF.3020005@gmail.com>; from iogl64nx@gmail.com on Sun, May 29, 2005 at 11:53:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 11:53:03PM +0200, Michael Thonke wrote:
> Matthias-Christian Ott schrieb:
> 
> > Michael Thonke wrote:
> >
> >> Hello,
> >>
> >> I recently bought an Asus P5WAD2 motherboard which uses the Intel 955x
> >> chipset.
> >> I noticed that CPUFREQ/speedsteps with the same kernel and same
> >> config from
> >> my system with Intel 925XE and Intel Pentium 640 does not work on the
> >> system with
> >> Intel 955X chipset (the processor is the same). In Windows it works
> >> perfectly on 925XE
> >> and 955X chipset.
> >> The kernels I used
> >>
> >> 2.6.12-rc5 vanilla with git4 patch
> >> 2.6.12-rc5-mm1.
> >>
> >> I attached the output of dmesg and `cat /proc/cpuinfo`
> >>
> > Please turn on cpufreq debugging (see Documentation/ for details) and
> > post the output.
> >
> Hello,
> 
> the debug infos show following when I try to modprobe speedstep-centrino.
> 
>     speedstep-centrino: Invalid control/status registers (1 - 1)
>     speedstep-centrino: <6>speedstep-centrino: invalid ACPI data
>     speedstep-centrino: <6>speedstep-centrino: found unsupported CPU
>     with Enhanced SpeedStep: send /proc/cpuinfo to Jeremy Fitzhardinge
>     <jeremy@goop.org>
>     speedstep-centrino: Invalid control/status registers (1 - 1)
>     speedstep-centrino: <6>speedstep-centrino: invalid ACPI data
> 
> cpuinfo follows

Can you please try acpi-cpufreq driver instead. That should work in this case.

Thanks,
Venki

