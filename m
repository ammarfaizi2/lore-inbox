Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSIPFkJ>; Mon, 16 Sep 2002 01:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSIPFkJ>; Mon, 16 Sep 2002 01:40:09 -0400
Received: from dsl-213-023-021-198.arcor-ip.net ([213.23.21.198]:39046 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317402AbSIPFkI>;
	Mon, 16 Sep 2002 01:40:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] per-zone kswapd process
Date: Mon, 16 Sep 2002 07:44:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <3D815C8C.4050000@us.ibm.com> <3D81643C.4C4E862C@digeo.com> <20020913045938.GG2179@holomorphy.com>
In-Reply-To: <20020913045938.GG2179@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qogR-0000HR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 06:59, William Lee Irwin III wrote:
> On Thu, Sep 12, 2002 at 09:06:20PM -0700, Andrew Morton wrote:
> > I still don't see why it's per zone and not per node.  It seems strange
> > that a wee little laptop would be running two kswapds?
> > kswapd can get a ton of work done in the development VM and one per
> > node would, I expect, suffice?
> 
> Machines without observable NUMA effects can benefit from it if it's
> per-zone.

How?

-- 
Daniel
