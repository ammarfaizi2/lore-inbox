Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUHBMKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUHBMKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266493AbUHBMKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:10:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266492AbUHBMKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:10:39 -0400
Date: Mon, 2 Aug 2004 08:10:30 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408020806210.13053@dhcp030.home.surriel.com>
References: <20040802015527.49088944.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Andrew Morton wrote:

> - Added Rik's token-based load control patch.  The VM currently has pretty
>   bad performance problems under heavy swapping loads and this patch speeds up
>   simple tests most impressively.  People who care about these things: please
>   test and measure.

I would really appreciate any testing results on this, both good
and bad.  I want to get this thing tuned and into a generally good
shape for use by everybody upstream.

I'm especially interested in how this affects compute servers,
desktops and heavily overloaded network servers (the "spamassassin
slowed my system to a crawl" symptom would be one to test ;)).

I suspect the patch may need some tweaking to help interactivity
in some cases, but maybe it'll already work magically by itself...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
