Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSA2B3E>; Mon, 28 Jan 2002 20:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSA2B2y>; Mon, 28 Jan 2002 20:28:54 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:28040 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288149AbSA2B2r>;
	Mon, 28 Jan 2002 20:28:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 02:32:58 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com> <3C55E9E3.50207@namesys.com> <E16VMUj-0000Dz-00@starship.berlin>
In-Reply-To: <E16VMUj-0000Dz-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VN8w-0000Ei-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 01:51 am, Daniel Phillips wrote:
> You don't worry about that case.  If there's so much pressure that you
> scan all the way to the hot end of the lru list then you will recover
> that hot/cold page[1] and all will be well.  Not that the hot/cold page
                                      "Note"  ^^^
> will tend to migrate further away from the hot end of the list than a
> hot/hot page.

-- 
Daniel
