Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVCOQyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVCOQyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVCOQyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:54:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261454AbVCOQxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:53:49 -0500
Date: Tue, 15 Mar 2005 11:53:37 -0500
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Andrew Clayton <andrew@digital-domain.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm lockups since 2.6.11-bk2
Message-ID: <20050315165337.GG15531@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>,
	Andrew Clayton <andrew@digital-domain.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0503151033110.22756@skynet> <20050315143629.GA27654@redhat.com> <Pine.LNX.4.58.0503151610560.443@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503151610560.443@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 04:15:42PM +0000, Dave Airlie wrote:
 > 
 > >  >
 > >  > I might get time to do a code review, my main worry is that all the
 > >  > problems reported with those patches in -mm made it into the patchset that
 > >  > went into Linus.. mainly things like forgetting to memset certain
 > >  > structures to 0 and sillies like that...
 > >
 > > I saw one report where the recent drm security hole fix broke dri
 > > for one user.  Whilst it seems an isolated incident, could this have
 > > more impact than we first realised ?
 > 
 > the radeon security changes? I've gotten no bad feedback on those neither
 > has dri-devel, so I've assumed they were all fine (usually radeon bug
 > reports get back fairly quickly as everyone has one ..),
 > 
 > the multi-bridge stuff is definitely broken as I've seen radeon and r128
 > reports on it .. and it looks most like 2.6.11-bk2 broke things and I
 > haven't merged anything until -bk7 ...

Wait, -bk2 broke things ?   The big agp changes went into -bk3,
so this seems odd.

		Dave

