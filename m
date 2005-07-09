Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVGITRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVGITRD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVGITRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:17:02 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16552 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261712AbVGITQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:16:02 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <20050709121212.7539a048.akpm@osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <1120933916.3176.57.camel@laptopd505.fenrus.org>
	 <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 15:16:01 -0400
Message-Id: <1120936561.6488.84.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 12:12 -0700, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> >  > This is not a userspace visible thing really with few exceptions, and
> >  > well people can select the one they want, right?
> > 
> >  Then why not leave the default at 1000?
> 
> Because some machines exhibit appreciable latency in entering low power
> state via ACPI, and 1000Hz reduces their battery life.  By about half,
> iirc.
> 

Then the owners of such machines can use HZ=250 and leave the default
alone.  Why should everyone have to bear the cost?

Lee

