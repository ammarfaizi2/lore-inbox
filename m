Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWBOSVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWBOSVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWBOSVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:21:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:6831 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751221AbWBOSVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:21:53 -0500
Subject: Re: Problems with sound on latest kernels.
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: elezeta@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060214232222.1016fe87.akpm@osdl.org>
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
	 <1139934640.11659.95.camel@mindpipe>
	 <20060214232222.1016fe87.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 13:21:50 -0500
Message-Id: <1140027710.2733.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 23:22 -0800, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Tue, 2006-02-14 at 14:58 +0100, Lz wrote:
> > > Hello,
> > > 
> > > I can't manage to get my sound cards (SB VIBRA and SB AWE 32) working
> > > on the latest kernels (> 2.6.14 approximately).
> > > 
> > 
> > Please use ALSA CVS to do a binary search by date to identify the change
> > that broke it.
> > 
> 
> Poor guy - that's rocket science.  It looks like it's due to breakage in
> the pnp code anwyay.

Well, it's no harder than git bisect.  And more people know CVS.  But
yes, it would be nice if there were an easier way to identify
regressions.

Lee

