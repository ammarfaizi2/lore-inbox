Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbTIAGD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTIAGD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:03:59 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:11376 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262618AbTIAGD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:03:58 -0400
Date: Mon, 1 Sep 2003 02:03:55 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Dan Kegel <dank@kegel.com>
cc: linux-kernel@vger.kernel.org, <jamie@shareable.org>
Subject: Re: Andrea VM changes
In-Reply-To: <3F529A95.4030509@kegel.com>
Message-ID: <Pine.LNX.4.44.0309010203060.25149-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003, Dan Kegel wrote:
> Jamie Lokier <jamie () shareable ! org> wrote:
> > I'd love to be able to select which app _doesn't_ deserve the axe.
> > I.e. not sshd, and then not httpd.
> 
> I tried adding a hinting system that let the user
> tweak the badness calculated by the OOM killer.
> Didn't help.   No matter how I tried to protect
> important processes, there was always a case where
> the OOM killer ended up killing them anyway.

Indeed.  You can't have completely fool-proof heuristics.

Then again, a heuristic is often better than killing
syslogd at the first hint of trouble.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

