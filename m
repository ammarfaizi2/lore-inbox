Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSIBKAx>; Mon, 2 Sep 2002 06:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSIBKAx>; Mon, 2 Sep 2002 06:00:53 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:10376 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318253AbSIBKAv>;
	Mon, 2 Sep 2002 06:00:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Neil Brown <neilb@cse.unsw.edu.au>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Date: Mon, 2 Sep 2002 12:07:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>, Rusty Russell <rusty@rustcorp.com.au>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20020902003318.7CB682C092@lists.samba.org> <20020902060257.GO888@holomorphy.com> <15731.1019.581339.120099@notabene.cse.unsw.edu.au>
In-Reply-To: <15731.1019.581339.120099@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lo6q-0004gE-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 08:23, Neil Brown wrote:
> On Sunday September 1, wli@holomorphy.com wrote:
> > On Mon, 2002-09-02 at 01:23, Rusty Russell wrote:
> > >> This week, it spread to SCTP.
> > >> "struct list_head" isn't a great name, but having two names for
> > >> everything is yet another bar to reading kernel source.
> > 
> > On Mon, Sep 02, 2002 at 01:51:54AM -0400, Robert Love wrote:
> > > I am all for your cleanup here, but two nits:
> > > Why not rename list_head while at it?  I would vote for just "struct
> > > list" ... the name is long, and I like my lines to fit 80 columns.
> > 
> > Seconded. Throw the whole frog in the blender, please, not just
> > half.
> 
> The struct in question is a handle on an element of a list, or the
> head of a list, but it is not a list itself.  A list is a number of
> stuctures each of which contain (inherit from?)  the particular
> structure.  So calling it "struct list" would be wrong, because it
> isn't a list, only part of one.

Pffft.  A struct page isn't a page either.

-- 
Daniel
