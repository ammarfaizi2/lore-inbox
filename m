Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136267AbRD0WkO>; Fri, 27 Apr 2001 18:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136256AbRD0WkE>; Fri, 27 Apr 2001 18:40:04 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:12487 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S136253AbRD0Wjz>; Fri, 27 Apr 2001 18:39:55 -0400
Date: Fri, 27 Apr 2001 23:40:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.4.33.0104271842550.17635-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104272337120.5472-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Rik van Riel wrote:
> On Fri, 27 Apr 2001, LA Walsh wrote:
> 
> >     An interesting option (though with less-than-stellar performance
> > characteristics) would be a dynamically expanding swapfile.  If you're
> > going to be hit with swap penalties, it may be useful to not have to
> > pre-reserve something you only hit once in a great while.
> 
> This makes amazingly little sense since you'd still need to
> pre-reserve the disk space the swapfile grows into.

It makes roughly the same sense as over-committing memory.
Both are useful, both are unreliable.

Hugh

