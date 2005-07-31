Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVGaWIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVGaWIy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVGaWIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:08:53 -0400
Received: from atpro.com ([12.161.0.3]:11022 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262004AbVGaWIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:08:48 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Sun, 31 Jul 2005 18:07:55 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050731220754.GE7362@voodoo>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	James Bruce <bruce@andrew.cmu.edu>,
	Lee Revell <rlrevell@joe-job.com>,
	Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731211020.GB27433@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/05 11:10:20PM +0200, Pavel Machek wrote:
> 
> > I really like having 250HZ as an _option_, but what I don't see is why 
> > it should be the _default_.  I believe this is Lee's position as
> > Last I checked, ACPI and CPU speed scaling were not enabled by default; 
> 
> Kernel defaults are irelevant; distros change them anyway. [But we
> probably want to enable ACPI and cpufreq by default, because that
> matches what 99% of users will use.]
> 

If the kernel defaults are irrelevant, then it would make more sense to
leave the default HZ as 1000 and not to enable the cpufreq and ACPI in
order to keep with the principle of least surprise for people who do use
kernel.org kernels.

Jim.
