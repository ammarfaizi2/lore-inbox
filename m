Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWFVGd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWFVGd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbWFVGd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:33:58 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:17627 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S932283AbWFVGd5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:33:57 -0400
From: CIJOML <cijoml@volny.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org,
       "Brodowski, Dominik" <linux@dominikbrodowski.net>,
       cpufreq@lists.linux.org.uk
Subject: Re: cpufreq doesn't work with my Intel Pentium M processor in 2.6.17
Date: Thu, 22 Jun 2006 08:33:47 +0200
User-Agent: KMail/1.9.1
References: <EB12A50964762B4D8111D55B764A8454192D25@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454192D25@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606220833.47956.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pallipadi,

no change:

#find /sys -name *freq*
/sys/module/acpi_cpufreq

no tuning options as you can see
module is compiled into kernel

Michal

Dne støeda 21 èerven 2006 21:27 jste napsal(a):
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of CIJOML
> >Sent: Sunday, June 18, 2006 11:06 PM
> >To: linux-kernel@vger.kernel.org
> >Subject: cpufreq doesn't work with my Intel Pentium M
> >processor in 2.6.17
> >
> >Hello team,
> >
> >I compiled 2.6.17 and now I see, that cpufreq doesn't work
> >with 2.6.17 (2.6.16
> >was fine).
> >
> >My cpu:
> >Intel(R) Pentium(R) M processor 1.70GHz
> >cpu family 6
> >model 13
> >stepping 6
> >
> >Cpufreq doesn't start and also /sys files are not present/created
> >
> >My config:
> >[*] CPU Frequency scaling
> ><*> CPU frequency translation statistics
> >[*] CPU frequency translation statistics details
> >governors: <*> performance, powersave, ondemand, conservative
> ><*> Intel Enhanced SpeedStep
> >[*] Use ACPI tables to decode valid frequency/voltage pairs
> >[*] Built-in tables for Banias CPUs
>
> Can you also try
> [*] ACPI Processor P-states driver
>
> In the same config menu.
>
> Thanks,
> Venki
