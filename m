Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUIFAOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUIFAOe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUIFAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:14:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9377 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267354AbUIFAOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:14:32 -0400
Subject: Re: [BUG] r200 dri driver deadlocks
From: Lee Revell <rlrevell@joe-job.com>
To: Patrick McFarland <diablod3@gmail.com>
Cc: dri-devel@lists.sf.net, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <d577e569040905131870fa14a3@mail.gmail.com>
References: <d577e569040904021631344d2e@mail.gmail.com>
	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090413365f5e223d@mail.gmail.com>
	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090501224f252dbc@mail.gmail.com>
	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
	 <d577e569040905131870fa14a3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1094429682.29921.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Sep 2004 20:14:43 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 16:18, Patrick McFarland wrote:
> On Sun, 05 Sep 2004 13:40:54 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> > On Sun, 2004-09-05 at 04:22 -0400, Patrick McFarland wrote:
> > > On Sun, 05 Sep 2004 02:34:59 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> > > >
> > > > Where did you get r200_dri.so from?
> > >
> > > From the one that comes with the Deb X I mentioned above.
> > 
> > Please try something newer, e.g. my xlibmesa-gl1-dri-trunk or a binary
> > snapshot from dri.sf.net.
> 
> That shouldn't matter, should it? The userland stuff should never lock
> the machine up.
> I'll test it anyhow, though.

No, it shouldn't.  Anything that directly accesses hardware belongs in
the kernel.  How to fix this is a pretty hot topic now.

Lee

