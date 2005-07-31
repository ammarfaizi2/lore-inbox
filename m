Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVGaWnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVGaWnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVGaWlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:41:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:14739 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262028AbVGaWjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:39:23 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050731223616.GB27580@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
	 <1122678943.9381.44.camel@mindpipe>
	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <20050731220754.GE7362@voodoo>  <20050731223616.GB27580@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 18:39:21 -0400
Message-Id: <1122849562.13000.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 00:36 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > I really like having 250HZ as an _option_, but what I don't see is why 
> > > > it should be the _default_.  I believe this is Lee's position as
> > > > Last I checked, ACPI and CPU speed scaling were not enabled by default; 
> > > 
> > > Kernel defaults are irelevant; distros change them anyway. [But we
> > > probably want to enable ACPI and cpufreq by default, because that
> > > matches what 99% of users will use.]
> > > 
> > 
> > If the kernel defaults are irrelevant, then it would make more sense to
> > leave the default HZ as 1000 and not to enable the cpufreq and ACPI in
> > order to keep with the principle of least surprise for people who do use
> > kernel.org kernels.
> 
> Well, I'd say you want ACPI enabled. New machine do not even boot
> without that. Default config should be usefull; set ACPI off, and
> you'll not be able to even power machine down.

While it's good to be future proof, I don't think it's valid to assume
that new kernels usually run on new hardware.

Lee

