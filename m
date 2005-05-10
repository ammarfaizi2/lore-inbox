Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVEJMKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVEJMKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVEJMKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:10:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28363 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261542AbVEJMKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:10:25 -0400
Date: Tue, 10 May 2005 08:09:25 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm: fix rss counter being incremented when unmapping
In-Reply-To: <20050509122916.GA30726@doener.homenet>
Message-ID: <Pine.LNX.4.61.0505100808320.24219@chimarrao.boston.redhat.com>
References: <20050509122916.GA30726@doener.homenet>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279726928-1609229727-1115726965=:24219"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279726928-1609229727-1115726965=:24219
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 9 May 2005, Björn Steinbrink wrote:

> This patch fixes a bug introduced by the "mm counter operations through
> macros" patch, which replaced a decrement operation in with an increment
> macro in try_to_unmap_one().

Oops.  Patch looks good to me.
Andrew, if you see this could you pick up the
patch from the head of this thread? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
--279726928-1609229727-1115726965=:24219--
