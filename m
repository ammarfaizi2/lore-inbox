Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWDXCjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWDXCjX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 22:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWDXCjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 22:39:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55474 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751490AbWDXCjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 22:39:22 -0400
Subject: Re: [Alsa-devel] Re: ALSA regression: oops on shutdown
From: Lee Revell <rlrevell@joe-job.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org
In-Reply-To: <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com>
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
	 <20060423185721.39ff4207.akpm@osdl.org>
	 <b6fcc0a0604231937h6f2754f9k68ec76dc19c7ddb9@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 22:39:19 -0400
Message-Id: <1145846360.31507.50.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-23 at 19:37 -0700, Alexey Dobriyan wrote:
> On 4/23/06, Andrew Morton <akpm@osdl.org> wrote:
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > ALSA oops I reported against 2.6.16-rc1-mm4 [1] sneaked into mainline
> > >  after release.
> >
> > One wonders why the ALSA developers merged up which was known to cause
> > oopses.
> 
> To be fair, I bisected it only to git-alsa.patch back then and only
> now found enough time, so
> blame me.

Do you have procfs disabled?  Full config is needed to debug this more.

Lee

