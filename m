Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284464AbRLMRkI>; Thu, 13 Dec 2001 12:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284472AbRLMRj6>; Thu, 13 Dec 2001 12:39:58 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:65172 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S284464AbRLMRjx>; Thu, 13 Dec 2001 12:39:53 -0500
Date: Thu, 13 Dec 2001 09:38:36 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Hugh Dickins <hugh@veritas.com>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
In-Reply-To: <Pine.LNX.4.21.0112131657290.1540-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112130920260.19658-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Hugh Dickins wrote:

> My fear is that you may encounter an indefinite number of buggy apps,
> which expect an mmap() to follow the mmap() before: easy bug to
> commit, and to go unnoticed, until you reverse the layout.

Hmm, so which is more important to support, buggy users of (unguaranteed
side effects of) the new interface, or users of the legacy interface?  I
can see the argument that that the buggy users of the new interface are
more important.  Maybe CONFIG_MMAP_GROWS_DOWNWARDS, or a /proc entry?

Wayne



