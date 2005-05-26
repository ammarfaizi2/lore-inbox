Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVEZVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVEZVFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEZVFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:05:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29157 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261793AbVEZVEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:04:39 -0400
Subject: Re: 2.6.12-rc5-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jamagallon@able.es, tomlins@cam.org,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
In-Reply-To: <20050526134532.1580defc.akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org>
	 <1117093392l.17165l.0l@werewolf.able.es>
	 <20050526005841.08a8aae0.akpm@osdl.org> <200505261554.54807.rjw@sisk.pl>
	 <20050526134532.1580defc.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 26 May 2005 17:04:36 -0400
Message-Id: <1117141476.6705.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 13:45 -0700, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > n Thursday, 26 of May 2005 09:58, Andrew Morton wrote:
> >  > "J.A. Magallon" <jamagallon@able.es> wrote:
> >  > >
> >  > > 
> >  > > On 05.26, Andrew Morton wrote:
> >  > > > 
> >  > > > (Added alsa-devel to cc)
> >  > > > 
> >  > > > Ed Tomlinson <tomlins@cam.org> wrote:
> >  > > > > 
> >  > > > > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
> >  > > > > 
> >  > > 
> >  > > Me too. As beep-media-player ends playing a mp3 track, oops !
> >  > 
> >  > hm, OK, you're also on x86_64.  What sound card and driver?
> > 
> >  I've got the following on a dual-Opteron box with Tyan Thunder K8W (snd_intel8x0):
> 
> OK, thanks.  I guess we can set this problem aside for now, as this bug
> isn't present in 2.6.12-rc5 (correct?).
> 
> I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> possible that it lies elsewhere.

See the "Patch avoiding-mmap-fragmentation-fix-2.patch oops" thread.

Lee

