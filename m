Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWDFEJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWDFEJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWDFEJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:09:14 -0400
Received: from theorix.CeNTIE.NET.au ([202.9.6.84]:38868 "HELO
	theorix.CeNTIE.NET.au") by vger.kernel.org with SMTP
	id S1751371AbWDFEJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:09:13 -0400
Subject: Re: 2.6.16-rt11 and low-latency audio xruns (interrupt latency
	problem?)
From: "Valin, Jean-Marc (ICT Centre, Marsfield)" <jean-marc.valin@csiro.au>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143699565.7328.8.camel@theorix.CeNTIE.NET.au>
References: <1143695638.7328.5.camel@theorix.CeNTIE.NET.au>
	 <1143699333.15145.20.camel@mindpipe>
	 <1143699565.7328.8.camel@theorix.CeNTIE.NET.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Apr 2006 14:09:04 +1000
Message-Id: <1144296544.21536.11.camel@theorix.CeNTIE.NET.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 17:19 +1100, Valin, Jean-Marc (ICT Centre,
Marsfield) wrote:
> > It's possible that your hardware simply isn't capable of this and you'll
> > have to get a multichannel soundcard (more channels means you can use a
> > smaller buffer before hitting the lower limit of a PCI transfer) or use
> > a period of 128 samples or more.

Could you give me more info on that PCI transfer limit? I couldn't find
any reference to that on the web. Also, any way to see if that's the
real cause of the problem. I've been doing some experiments and noticed
that the percentage or xruns I get is almost independent of the period
size, which is a little odd. Any idea?

	Jean-Marc
