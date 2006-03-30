Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWC3GT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWC3GT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWC3GT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:19:28 -0500
Received: from theorix.CeNTIE.NET.au ([202.9.6.84]:4752 "HELO
	theorix.CeNTIE.NET.au") by vger.kernel.org with SMTP
	id S1751117AbWC3GT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:19:27 -0500
Subject: Re: 2.6.16-rt11 and low-latency audio xruns (interrupt latency
	problem?)
From: "Valin, Jean-Marc (ICT Centre, Marsfield)" <jean-marc.valin@csiro.au>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143699333.15145.20.camel@mindpipe>
References: <1143695638.7328.5.camel@theorix.CeNTIE.NET.au>
	 <1143699333.15145.20.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Mar 2006 17:19:25 +1100
Message-Id: <1143699565.7328.8.camel@theorix.CeNTIE.NET.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's possible that your hardware simply isn't capable of this and you'll
> have to get a multichannel soundcard (more channels means you can use a
> smaller buffer before hitting the lower limit of a PCI transfer) or use
> a period of 128 samples or more.

>From the ALSA verbose mode, I can see that the hardware does accept as
low as 8 samples per period -- and it actually works outside of the few
xruns per minute. 

	Jean-Marc
