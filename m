Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315425AbSEBVOz>; Thu, 2 May 2002 17:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315426AbSEBVOx>; Thu, 2 May 2002 17:14:53 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:7586 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315425AbSEBVOw>;
	Thu, 2 May 2002 17:14:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>, Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
Date: Thu, 2 May 2002 23:13:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, marcelo@brutus.conectiva.com.br,
        linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.21.0205021312370.999-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173NtU-0002Ak-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 15:08, Hugh Dickins wrote:
> On Thu, 2 May 2002, Suparna Bhattacharya wrote:
> As someone else noted in this thread, the kernel tries to keep
> pages in use anyway, so omitting free pages won't buy you a great
> deal on its own.  And I think it's to omit free pages that you want
> to distinguish the count 0 continuations from the count 0 frees?

Then why not count=-1 for the continuation pages?

-- 
Daniel
