Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSIORAo>; Sun, 15 Sep 2002 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSIORAo>; Sun, 15 Sep 2002 13:00:44 -0400
Received: from dsl-213-023-039-078.arcor-ip.net ([213.23.39.78]:43905 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318121AbSIORAo>;
	Sun, 15 Sep 2002 13:00:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.5.34-mm2
Date: Sun, 15 Sep 2002 19:08:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D841C8A.682E6A5C@digeo.com> <Pine.LNX.4.44L.0209151156080.1857-100000@imladris.surriel.com> <3D84BFC8.2D8A7592@digeo.com>
In-Reply-To: <3D84BFC8.2D8A7592@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qcsi-0000DE-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 19:13, Andrew Morton wrote:
> Yes, I'm not particularly fussed about (moderate) excess CPU use in these
> situations, and nor about page replacement accuracy, really - pages
> are being slushed through the system so fast that correct aging of the
> ones on the inactive list probably just doesn't count.

What you really mean is, it hasn't gotten to the top of the list
of things that suck.  When we do get around to fashioning a really
effective page ager (LRU-er, more likely) the further improvement
will be obvious, especially under heavy streaming IO load, which
is getting more important all the time.

-- 
Daniel
