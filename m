Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTJMSwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTJMSwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 14:52:13 -0400
Received: from imladris.surriel.com ([66.92.77.98]:28873 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261841AbTJMSwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 14:52:12 -0400
Date: Mon, 13 Oct 2003 14:51:55 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Roger Luethi <rl@hellgate.ch>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] State of ru_majflt
In-Reply-To: <20031013165104.GA14720@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.55L.0310131451310.27244@imladris.surriel.com>
References: <20031013165104.GA14720@k3.hellgate.ch>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Roger Luethi wrote:

> A proper solution would probably have filemap_nopage tell its caller the
> correct return code.

Agreed.

> Is this considered a bug or is it a documentation issue? How much do we
> care?

It's a bug, but I'm not quite sure how much we care.

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
