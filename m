Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267425AbUHDVGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbUHDVGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUHDVGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:06:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267425AbUHDVGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:06:11 -0400
Date: Wed, 4 Aug 2004 17:06:08 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Arjan Van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mlock-as-user for 2.6.8-rc2-mm2
In-Reply-To: <20040804140102.O1924@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0408041705130.9630-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Chris Wright wrote:

> The default lockable amount is one page now (first patch is was 0).
> Why don't we keep it as 0, with the CAP_IPC_LOCK overrides in place?

My mistake, I went from Arjan's 2.6 submitted version to
the version in Fedora.  The 0 limits are probably better
for upstream.

> Incremental update below.  Ran some simple sanity tests on this plus my
> patch below and didn't find any problems.

Looks good to me.

Andrew, could you please apply Chris's patch in addition
to mine ?

thanks,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

