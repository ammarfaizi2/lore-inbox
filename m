Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263904AbUDVKTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUDVKTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 06:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbUDVKTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:19:09 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:19165
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S263904AbUDVKTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:19:07 -0400
Subject: Re: Speedstep on centrino
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alexander Hoogerhuis <alexh@boxed.no>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       cpufreq list <cpufreq@www.linux.org.uk>
In-Reply-To: <87n05aoxpa.fsf@dorker.boxed.no>
References: <87n05aoxpa.fsf@dorker.boxed.no>
Content-Type: text/plain
Message-Id: <1082629118.5672.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 20:18:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-18 at 11:56, Alexander Hoogerhuis wrote:
> I've been twaddling with getting SpeedStep right on my laptop (HP
> nc6000, 1.6GHz P-M) and noticed a few odd things:
> 
> Using regular SpeedStep is says to use speedstep-centrino due to
> voltage regultion, etc.

Yep, that's reasonable.

> 
> Using SpeedStep for Centrino og gived me this line on boot:
> speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz

Looks normal.

> This seems to work and make the battery last an useful amount of time.

Good.

> Using SpeedStep for Centrino with decoding the speeds and voltages
> (CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI) will not yield any output during
> boot regarding cpufreq at all and the battery useage is heavy. ACPI is
> enabled. 

I've never managed to get ACPI working on my laptop, so I haven't tested
this.  I'm not sure what's going on here - maybe someone on the cpufreq
list can help.

	J

