Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUIANPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUIANPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUIANPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:15:10 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:6062 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266486AbUIANOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:14:55 -0400
Date: Wed, 1 Sep 2004 14:14:34 +0100
From: Dave Jones <davej@redhat.com>
To: Romain Moyne <aero_climb@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
Message-ID: <20040901131434.GB11182@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Romain Moyne <aero_climb@yahoo.fr>, linux-kernel@vger.kernel.org
References: <200409021453.09730.aero_climb@yahoo.fr> <200409021708.31410.aero_climb@yahoo.fr> <20040901130011.GB10829@redhat.com> <200409021831.55002.aero_climb@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409021831.55002.aero_climb@yahoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 06:31:54PM +0200, Romain Moyne wrote:
 > Le Mercredi 01 Septembre 2004 15:00, Dave Jones a écrit :
 > > On Thu, Sep 02, 2004 at 05:08:30PM +0200, Romain Moyne wrote:
 > >  > >Do you have files in /sys/devices/system/cpu/cpu0/cpufreq ?
 > >  >
 > >  > I don't.
 > >
 > > what about after modprobe powernow-k8 ?
 > > (that should also print out some messages in dmesg)
 > 
 > powernow-k8 is for athlon64, no ? I have just compiled in the kernel (not as a 
 > module) the option powernow-k7 (I have a Athlon XP-M).
 > So, I can't do modprobe powernow-k7...

You have one of the 32bit models of the athlon64. (Basically a crippled athlon64)
(See proc/cpuinfo..)

cpu family      : 15

I've not heard reports of whether powernow-k8 works or not on these cpu's,
but it should if the cpu reports the powernow capability bits.

My suspicion is that for some reason, your cpu is booting at a low speed.
Are there any powernow/power management settings in the BIOS that change
this ?

		Dave

