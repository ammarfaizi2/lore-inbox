Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWB1Vec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWB1Vec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWB1Vec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:34:32 -0500
Received: from isilmar.linta.de ([213.239.214.66]:15853 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932501AbWB1Vea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:34:30 -0500
Date: Tue, 28 Feb 2006 22:34:28 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Matt Mackall <mpm@selenic.com>
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060228213428.GA31044@isilmar.linta.de>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk, ak@suse.de
References: <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com> <20060228194628.GP4650@waste.org> <20060228200916.GA326@redhat.com> <20060228204720.GD13116@waste.org> <20060228205758.GA16268@isilmar.linta.de> <20060228212632.GE13116@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060228212632.GE13116@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 03:26:32PM -0600, Matt Mackall wrote:
> > So even if the battery lasts longer, you don't have anything of it, 'cause
> > the CPU can even compute _less_ in this longer time-span. Remember that
> > idling doesn't count...
> 
> Which is different from other power-saving modes how? If it means I
> can read my email longer on the plane, it's a power-saving mode.

But you can't... [*]

> > > In short, power usage and heat production are _the same thing_.
> > 
> > Yes and no. The heat production is more levelled if you use throttling, so
> > the temperature achieved is lesser, which might cause fans not having to
> > start or air conditioning having less work to do.
> 
> The time scale for heat propagation is enough slower than throttling
> that I'd expect this difference to amount to approximately nil.

For short-term load spikes, yes. If your server has a task which takes up
one hour at full time, and the temp reaches 45° C then, but you have nothing
else for it to do overnight, then it does might sense to throttle it to
50%, which will mean two hours, but only 40° C.

	Dominik


[*] unless the idling algorithm is broken and does not enter C2-type idle
states.
