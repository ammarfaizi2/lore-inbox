Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUJWFPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUJWFPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUJWFN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:13:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62694 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266538AbUJWFLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:11:47 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098444170.19459.7.camel@localhost.localdomain>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 23 Oct 2004 01:10:37 -0400
Message-Id: <1098508238.13176.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 12:23 +0100, Alan Cox wrote:
> On Gwe, 2004-10-22 at 00:01, Lee Revell wrote:
> > JACK needs to know the CPU speed, in order to calculate the DSP load
> > among other things.  It used to be a valid assumption that you could
> > calculate it on startup and it would not change.
> 
> No it did not. It has never been a safe assumption.

OK, thanks.  Still no answer to my original question though.

JACK makes extensive use of microsecond-level timers.  These must be
calibrated at startup, and recalibrated when the CPU speed changes.  How
does JACK register with the kernel to be notified when the CPU speed
changes?

Lee


