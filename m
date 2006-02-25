Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbWBYMyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWBYMyW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWBYMyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:54:22 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:17804 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932704AbWBYMyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:54:21 -0500
Date: Sat, 25 Feb 2006 13:53:37 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Message-ID: <20060225125337.GB8698@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk, ak@suse.de
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org> <20060225042456.GA7851@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225042456.GA7851@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.211.213
Subject: Re: Status of X86_P4_CLOCKMOD?
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006, Dave Jones wrote:
> On Sat, Feb 25, 2006 at 02:57:22AM +0100, Johannes Stezenbach wrote:
>  > On Thu, Feb 23, 2006, Dave Jones wrote:
>  > > On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
>  > >  > And if the option is mostly useless, what is it good for?
>  > > 
>  > > It's sometimes useful in cases where the target CPU doesn't have any better
>  > > option (Speedstep/Powernow).  The big misconception is that it
>  > > somehow saves power & increases battery life. Not so.
>  > > All it does is 'not do work so often'.  The upside of this is
>  > > that in some situations, we generate less heat this way.
>  > 
>  > Doesn't less heat imply less power consumption?
> 
> Not really.  The only energy you're saving is that your CPU fan
> will turn slightly slower, which is probably going to be < 1W
> of difference.

I thought the fan turns slower because the CPU generates
less heat, which in turn is because it consumes less
electrical energy.

If someone has done measurements I'd be interested to
know the numbers about the actual power savings which
can be achieved by using P4 clock mod. I don't expect
it to be much, but I bet it's more than 1W.


Johannes
