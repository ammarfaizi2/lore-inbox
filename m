Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUALV2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUALV2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:28:33 -0500
Received: from AGrenoble-101-1-2-140.w193-253.abo.wanadoo.fr ([193.253.227.140]:61363
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S266237AbUALV2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:28:19 -0500
Subject: Re: Laptops & CPU frequency
From: Xavier Bestel <xavier.bestel@free.fr>
To: john stultz <johnstul@us.ibm.com>
Cc: Robert Love <rml@ximian.com>, jlnance@unity.ncsu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073937159.28098.46.camel@cog.beaverton.ibm.com>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
	 <1073817226.6189.189.camel@nomade>
	 <1073937159.28098.46.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073942913.724.10.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 22:28:34 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 12/01/2004 à 20:52, john stultz a écrit :

> More info please. What type of hardware is this?  Could you send me your
> dmesg for booting both with and without AC power? 

It's an Armada 1700, with a pII 300MHz (150MHz on battery). It doesn't
support cpufreq (I tried modprobing all drivers, none work), I must boot
with acpi=off if I want suspend-to-ram and suspend-to-disk to work (apm
works great on this machine). As said elsewhere in this thread, booting
with clock=pit solves my problem.
Yet I can investigate for you (send dmesg, test things) if you're still
interested.

Thanks,

	Xav

