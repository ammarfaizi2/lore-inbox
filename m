Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWBKC26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWBKC26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 21:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWBKC26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 21:28:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31421 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932086AbWBKC25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 21:28:57 -0500
Subject: Re: 2.6.16-rc2-mm1 -- BUG: warning at
	drivers/ieee1394/ohci1394.c:235/get_phy_reg()
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Miles Lane <miles.lane@gmail.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <20060210122131.4b98cfb4.akpm@osdl.org>
References: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>
	 <20060210122131.4b98cfb4.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 21:28:50 -0500
Message-Id: <1139624931.19342.46.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 12:21 -0800, Andrew Morton wrote:
> Miles Lane <miles.lane@gmail.com> wrote:
> >
> > BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
> 
> That's a -mm-only warning telling you that get_phy_reg() is doing a
> one-millisecond-or-more busywait while local interrupts are disabled.
> 
> That's the sort of thing which makes audio developers pursue 1394 developers
> with sharp sticks.

Hmm, interesting, did -mm get a "lite" version of Ingo's latency tracer?

Lee

