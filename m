Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTKQSym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTKQSyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:54:41 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:43896 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263691AbTKQSyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:54:40 -0500
Date: Mon, 17 Nov 2003 13:54:32 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Stan Bubrouski <stan@ccs.neu.edu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: Bad interactivity with 2.6-test9
In-Reply-To: <1069040526.23511.40.camel@duergar>
Message-ID: <Pine.LNX.4.44.0311171354050.27370-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003, Stan Bubrouski wrote:

> When I start watching a video under mplayer and have something like
> spamassassin doing a sa-learn in an x-term if I start the sa-learn
> before mplayer and then play a video, the sa-learn makes  no  progress
> until I switch away from mplayer (playing full screen).  After which
> sa-learn continues to filter through messages much faster, and even
> while mplayer is going is still progressing much faster than before I
> switched away from mplayer the first time.
> 
> Very odd.  Con anyone ideas?

Looks like scheduler starvation.  Con ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

