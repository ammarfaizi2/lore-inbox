Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWC3GPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWC3GPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWC3GPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:15:38 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:54189 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751104AbWC3GPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:15:38 -0500
Subject: Re: 2.6.16-rt11 and low-latency audio xruns (interrupt latency
	problem?)
From: Lee Revell <rlrevell@joe-job.com>
To: "Valin, Jean-Marc (ICT Centre, Marsfield)" <jean-marc.valin@csiro.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143695638.7328.5.camel@theorix.CeNTIE.NET.au>
References: <1143695638.7328.5.camel@theorix.CeNTIE.NET.au>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 01:15:32 -0500
Message-Id: <1143699333.15145.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 16:13 +1100, Valin, Jean-Marc (ICT Centre,
Marsfield) wrote:
> In this case,
> I'm running with two periods of 16 samples each (48 kHz), but I've
> seen
> that error occur with periods up to 64 samples.  

It's possible that your hardware simply isn't capable of this and you'll
have to get a multichannel soundcard (more channels means you can use a
smaller buffer before hitting the lower limit of a PCI transfer) or use
a period of 128 samples or more.

Lee

