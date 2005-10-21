Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVJUSq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVJUSq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVJUSq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:46:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29363 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965079AbVJUSq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:46:28 -0400
Subject: Re: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com>
References: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
	 <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 14:45:22 -0400
Message-Id: <1129920323.17709.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 10:40 -0700, Mark Knecht wrote:
> On 10/21/05, Mark Knecht <markknecht@gmail.com> wrote:
> > Hi,
> >    Maybe I'm catching something here? Maybe not - no xruns as of yet,
> > but I've never seen these messages before. Kernel config attached.
> >
> >    dmesg has filled up with these messages:
> >

This isn't a real problem.  You enabled CONFIG_RTC_HISTOGRAM.  Don't do
that.

Lee

