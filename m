Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSHBP7S>; Fri, 2 Aug 2002 11:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSHBP7A>; Fri, 2 Aug 2002 11:59:00 -0400
Received: from ns.suse.de ([213.95.15.193]:52484 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316465AbSHBP6D>;
	Fri, 2 Aug 2002 11:58:03 -0400
Date: Fri, 2 Aug 2002 18:01:32 +0200
From: Dave Jones <davej@suse.de>
To: gerg <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches
Message-ID: <20020802180132.P25761@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	gerg <gerg@snapgear.com>, linux-kernel@vger.kernel.org
References: <3D4A27FE.8030801@snapgear.com> <20020802141652.E25761@suse.de> <3D4AA573.3000705@snapgear.com> <20020802173449.N25761@suse.de> <3D4AAB32.8050608@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D4AAB32.8050608@snapgear.com>; from gerg@snapgear.com on Sat, Aug 03, 2002 at 01:54:26AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 01:54:26AM +1000, gerg wrote:

 > > I didn't check the code in detail, but
 > > is there really that little that can be shared between
 > > the regular mm/ ?
 > No, there is actually a lot in common. Probably something
 > like 70%. This is really a question of organization.

That's what I guessed on just a cursory glance at the patch.

 > I would much prefer to see the non-mmu support in with mm.
 > But it would mean a few #ifdef's in there to allow for
 > the differences.

Versus massive code duplication, I think the ifdef's would
be a better approach, especially if you can hide them away
in headers.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
