Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUJVSI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUJVSI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUJVSI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:08:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:18570 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267807AbUJVSFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:05:25 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098444170.19459.7.camel@localhost.localdomain>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1098468316.5580.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 14:05:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 07:23, Alan Cox wrote:
> On Gwe, 2004-10-22 at 00:01, Lee Revell wrote:
> > This issue came up on the JACK (http://jackit.sf.net) mailing list. 
> > Google was not helpful so I ask here.
> > 
> > JACK needs to know the CPU speed, in order to calculate the DSP load
> > among other things.  It used to be a valid assumption that you could
> > calculate it on startup and it would not change.
> 
> No it did not. It has never been a safe assumption. Even my old PC110
> does APM non-linux assisted shifts between 8 16 and 33Mhz. In addition
> there are boxes with dual CPU's and different multipliers - dual 
> 300/450's were not uncommon.
> 
> And thats before we even mention such things at hyped-threading.

Seems like you are implying that any userspace app that needs to know
the CPU speed is broken.  Is this correct?

Lee

