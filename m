Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317678AbSGJXfC>; Wed, 10 Jul 2002 19:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317679AbSGJXfC>; Wed, 10 Jul 2002 19:35:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49936 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317678AbSGJXfA>; Wed, 10 Jul 2002 19:35:00 -0400
Date: Thu, 11 Jul 2002 00:37:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020711003743.B25089@flint.arm.linux.org.uk>
References: <20020711001549.D17806@flint.arm.linux.org.uk> <E17SRB0-00086D-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17SRB0-00086D-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 11, 2002 at 12:47:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 12:47:18AM +0100, Alan Cox wrote:
> > What about /proc/sys/cpu/<number>/<datapoint> ?
> 
> What happens if the cpus are hot plugged and change ID while doing the
> config 8)

As far as SMP systems and cpufreq is concerned, we're going to have
a /proc/sys/cpu/all/ as well - you can't control the clock rate of
each cpu independently on such systems (otherwise they wouldn't be
very symetric.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

