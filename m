Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317669AbSGJXNM>; Wed, 10 Jul 2002 19:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSGJXNK>; Wed, 10 Jul 2002 19:13:10 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:39440 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317669AbSGJXNH>; Wed, 10 Jul 2002 19:13:07 -0400
Date: Thu, 11 Jul 2002 00:15:49 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020711001549.D17806@flint.arm.linux.org.uk>
References: <20020707002006.B5242@flint.arm.linux.org.uk> <200207070030.g670UbT166497@saturn.cs.uml.edu> <20020710002017.GA540@elf.ucw.cz> <3D2CB1D9.20807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D2CB1D9.20807@zytor.com>; from hpa@zytor.com on Wed, Jul 10, 2002 at 03:14:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 03:14:49PM -0700, H. Peter Anvin wrote:
> Pavel Machek wrote:
> > 
> > I thought that cpuinfo was ment to be non-chaning after boot? 
> > 
> > Perhaps we want /proc/cpu/0/temperature containing single int?
> > 
> 
> /proc/cpu/<number>/<datapoint> would be a lot better for a whole bunch
> of things.

What about /proc/sys/cpu/<number>/<datapoint> ?

We decided on the above path for cpufreq after mulling it over for several
weeks...  it might be a good idea if we can all agree to put stuff in one
place, rather than spreading it out across /crap^w/proc

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

