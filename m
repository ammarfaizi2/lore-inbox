Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVCORAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVCORAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVCORAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:00:40 -0500
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:9605 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S261481AbVCORAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:00:31 -0500
Subject: Re: drm lockups since 2.6.11-bk2
From: Andrew Clayton <andrew@rootshell.co.uk>
To: Dave Jones <davej@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Clayton <andrew@digital-domain.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <20050315165337.GG15531@redhat.com>
References: <Pine.LNX.4.58.0503151033110.22756@skynet>
	 <20050315143629.GA27654@redhat.com>
	 <Pine.LNX.4.58.0503151610560.443@skynet>
	 <20050315165337.GG15531@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 17:00:22 +0000
Message-Id: <1110906022.3244.111.camel@theta.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 11:53 -0500, Dave Jones wrote:
> On Tue, Mar 15, 2005 at 04:15:42PM +0000, Dave Airlie wrote:
>  > 
>  > >  >
>  > >  > I might get time to do a code review, my main worry is that all the
>  > >  > problems reported with those patches in -mm made it into the patchset that
>  > >  > went into Linus.. mainly things like forgetting to memset certain
>  > >  > structures to 0 and sillies like that...
>  > >
>  > > I saw one report where the recent drm security hole fix broke dri
>  > > for one user.  Whilst it seems an isolated incident, could this have
>  > > more impact than we first realised ?
>  > 
>  > the radeon security changes? I've gotten no bad feedback on those neither
>  > has dri-devel, so I've assumed they were all fine (usually radeon bug
>  > reports get back fairly quickly as everyone has one ..),
>  > 
>  > the multi-bridge stuff is definitely broken as I've seen radeon and r128
>  > reports on it .. and it looks most like 2.6.11-bk2 broke things and I
>  > haven't merged anything until -bk7 ...
> 
> Wait, -bk2 broke things ?   The big agp changes went into -bk3,
> so this seems odd.
> 

To clarify. 2.6.11-bk2 is working fine. It broke with 2.6.11-bk3, where
IIRC a drm update was made.

Disabling DRI in X and/or DRM in the kernel prevents X from locking the
machine.

> 		Dave
> 

Cheers,

Andrew

