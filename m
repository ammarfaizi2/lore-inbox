Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTKCDOR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 22:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTKCDOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 22:14:17 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:51481 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261890AbTKCDOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 22:14:14 -0500
Date: Sun, 2 Nov 2003 22:14:11 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ville Herva <vherva@niksula.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: getrlimit for an arbitrary process?
In-Reply-To: <20031102090505.GB9015@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.44.0311022213140.28000-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003, Ville Herva wrote:

> Is there a way to query/set getrlimit/setrlimit for an arbitrary process?

Nope, rlimits only work on the current process
(and a few of them work on the current UID).

> Couldn't find it under /proc, at least on 2.4.x.

Good idea for 2.7, though we might as well go
all the way and set up more arbitrary resource
groups.

Take a look at http://ckrm.sourceforge.net/  ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

