Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265177AbUD3Mzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUD3Mzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 08:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbUD3Mzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 08:55:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265177AbUD3Mzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 08:55:35 -0400
Date: Fri, 30 Apr 2004 08:54:08 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Erik Jacobson <erikj@subway.americas.sgi.com>, Paul Jackson <pj@sgi.com>,
       <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
In-Reply-To: <20040430071750.A8515@infradead.org>
Message-ID: <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Christoph Hellwig wrote:

> Still doesn't make a lot of sense.  CKRM is a huge cludgy beast poking
> everywhere while PAGG is a really small layer to allow kernel modules
> keeping per-process state.  If CKRM gets merged at all (and the current
> looks far to horrible and the gains are rather unclear) it should layer
> ontop of something like PAGG for the functionality covered by it.

What was the last time you looked at the CKRM source?

Sure it's a bit bigger than PAGG, but that's also because
it includes the functionality to change the group a process
belongs to and other things that don't seem to be included
in the PAGG patch.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

