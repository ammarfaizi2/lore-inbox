Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268138AbUJLBGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268138AbUJLBGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUJLBFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:05:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15772 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266888AbUJLBCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:02:30 -0400
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, thewade@aproximation.org
In-Reply-To: <20041011215909.GA20686@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu>
Content-Type: text/plain
Message-Id: <1097542629.1453.117.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 20:57:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 17:59, Ingo Molnar wrote:
> * Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:
> 
> > I would have to say this is "very rough" at this point. I had the
> > following problems in the build:
> 
> i've uploaded -T5 which should fix most of the build issues:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T5
> 

Ingo, are any of the VP patches known to work on x64?  Here is thewade's
latest report:

--

I applied the patch and the kernel built, but like 2.6.9-mm2-VP-S9 it
crashed before it could load. The last bit of the message was a lot of
what I guess are frame pointers, but there was a few lines that had
info.
For example an RIP message having to do with add_preempt_count+16

But it all ended with Aieee...

I have yet to get any VP kernel to run on my x86_64. I suppose I should
try just the mm3 or mm4 patches without the VP portion, so that is what
I will do.

--

Lee

