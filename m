Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUALWHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUALWHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:07:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56201 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266512AbUALWHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:07:36 -0500
Subject: Re: Laptops & CPU frequency
From: john stultz <johnstul@us.ibm.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Robert Love <rml@ximian.com>, jlnance@unity.ncsu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073942913.724.10.camel@nomade>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
	 <1073817226.6189.189.camel@nomade>
	 <1073937159.28098.46.camel@cog.beaverton.ibm.com>
	 <1073942913.724.10.camel@nomade>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1073945248.28098.49.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 14:07:28 -0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 13:28, Xavier Bestel wrote:
> Le lun 12/01/2004 à 20:52, john stultz a écrit :
> 
> > More info please. What type of hardware is this?  Could you send me your
> > dmesg for booting both with and without AC power? 
> 
> It's an Armada 1700, with a pII 300MHz (150MHz on battery). It doesn't
> support cpufreq (I tried modprobing all drivers, none work), I must boot
> with acpi=off if I want suspend-to-ram and suspend-to-disk to work (apm
> works great on this machine). As said elsewhere in this thread, booting
> with clock=pit solves my problem.
> Yet I can investigate for you (send dmesg, test things) if you're still
> interested.

Please do. I have code in the kernel that tries to detect when the
problem you see occurs, so we will drop back to the PIT automatically.
Somehow it seems we're not triggering that code in your case. 

thanks
-john


