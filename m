Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTKQUEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTKQUEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:04:40 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:15608 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S262131AbTKQUDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:03:39 -0500
Subject: Re: Bad interactivity with 2.6-test9
From: Stan Bubrouski <stan@ccs.neu.edu>
To: Rik van Riel <riel@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0311171354050.27370-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0311171354050.27370-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1069099418.23780.2.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Nov 2003 15:03:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 13:54, Rik van Riel wrote:
> On Sun, 16 Nov 2003, Stan Bubrouski wrote:
> 
> > When I start watching a video under mplayer and have something like
> > spamassassin doing a sa-learn in an x-term if I start the sa-learn
> > before mplayer and then play a video, the sa-learn makes  no  progress
> > until I switch away from mplayer (playing full screen).  After which
> > sa-learn continues to filter through messages much faster, and even
> > while mplayer is going is still progressing much faster than before I
> > switched away from mplayer the first time.
> > 
> > Very odd.  Con anyone ideas?
> 
> Looks like scheduler starvation.  Con ?

Seems like it.  I'll do some testing later to see exactly how
consistently I can reproduce this.  I have noticed this numerous times
all with -test9.

-sb

