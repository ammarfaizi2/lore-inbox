Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVJaQwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVJaQwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJaQwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:52:22 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13285 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932467AbVJaQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:52:22 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Kyle McMartin <kyle@parisc-linux.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051030151256.GZ4180@stusta.de>
References: <20051030105118.GW4180@stusta.de>
	 <20051030142752.GE6475@tachyon.int.mcmartin.ca>
	 <20051030151256.GZ4180@stusta.de>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 11:50:52 -0500
Message-Id: <1130777453.32101.46.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 16:12 +0100, Adrian Bunk wrote:
> On Sun, Oct 30, 2005 at 09:27:52AM -0500, Kyle McMartin wrote:
> > On Sun, Oct 30, 2005 at 11:51:18AM +0100, Adrian Bunk wrote:
> > > 
> > > This patch schedules obsolete OSS drivers (with ALSA drivers that support the
> > > same hardware) for removal.
> > >
> > 
> > I didn't see it here, but SOUND_AD1889 can definitely be removed
> > as well. The driver never worked properly to begin with. This was
> > ACK'd by the author last time this thread reared it's head.
> 
> ALSA bugs [1] #1301 and #1302 are still open.

I think these bug reports can be disregarded.  The submitter never
responded to requests to retest with the latest ALSA version.  #1302 is
almost certainly a bug in kphone anyway.

Lee

