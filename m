Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288658AbSANShW>; Mon, 14 Jan 2002 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSANShM>; Mon, 14 Jan 2002 13:37:12 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:25874 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S288756AbSANShG>;
	Mon, 14 Jan 2002 13:37:06 -0500
Date: Mon, 14 Jan 2002 18:36:59 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020114183658.GA29032@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: diamond@csn.ul.ie (Stephen Shirley)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	If, as Alan described, you can depend on the distro's installation
	program to have automatically identified all the hardware possible,
	and for the user to have specified and additional (i.e. isa etc) 
	devices, then could not the autoconfigurator simply see what drivers 
	are currently in use (via /proc/devices etc), check
	/etc/modules.conf for any that don't happen to be loaded at the
	time, and use that info to configure the new kernel. Unless there is
	some new piece of hardware that the new kernel supports that is
	present (and isn't supported by the old one), if linux was installed
	properly, you now have all the info you need, no? This removes the
	need for the configurator to do any sort of probing, neither are
	root proviledges required. Anyway, that's all probably blatantly
	obvious etc, so I'll just be quiet now.

Steve
-- 
"My mom had Windows at work and it hurt her eyes real bad"
