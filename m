Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWAUBaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWAUBaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWAUBav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:30:51 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:30671 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964776AbWAUBau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:30:50 -0500
Subject: Re: My vote against eepro* removal
From: Lee Revell <rlrevell@joe-job.com>
To: John Ronciak <john.ronciak@gmail.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, kus Kusche Klaus <kus@keba.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <56a8daef0601201719t448a6177lfebabe3ca38a00c7@mail.gmail.com>
References: <AAD6DA242BC63C488511C611BD51F367323324@MAILIT.keba.co.at>
	 <20060120095548.GA16000@2ka.mipt.ru> <1137804050.3241.32.camel@mindpipe>
	 <56a8daef0601201719t448a6177lfebabe3ca38a00c7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 20:30:48 -0500
Message-Id: <1137807048.3241.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 17:19 -0800, John Ronciak wrote:
> On 1/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > Seems like the important question is, why does e100 need a watchdog if
> > eepro100 works fine without one?  Isn't the point of a watchdog in this
> > context to work around other bugs in the driver (or the hardware)?
> There are a number of things that the watchdog in e100 does.  It
> checks link (up, down), reads the hardware stats, adjusts the adaptive
> IFS and checks to 3 known hang conditions based on certain types of
> the hardware.  You might be able to get around without doing the
> work-arounds (as long as you don't' see hangs happening with the
> hardware being used) but the checking of the link and the stats are
> probably needed.

Why don't these cause excessive scheduling delays in eepro100 then?
Can't we just copy the eepro100 behavior?

Lee

