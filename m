Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317724AbSGVRte>; Mon, 22 Jul 2002 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317730AbSGVRte>; Mon, 22 Jul 2002 13:49:34 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:42506 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S317724AbSGVRtd>;
	Mon, 22 Jul 2002 13:49:33 -0400
Date: Mon, 22 Jul 2002 11:52:31 -0600
From: Val Henson <val@nmt.edu>
To: Christoph Hellwig <hch@lst.de>, Andreas Schuldei <andreas@schuldei.org>,
       linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020722175231.GC18250@boardwalk>
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk> <20020722102930.A14802@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020722102930.A14802@lst.de>
User-Agent: Mutt/1.4i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 10:29:30AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2002 at 01:15:10AM -0600, Val Henson wrote:
> > Sigh.  I hate this question: "How will BitKeeper make it easier to
> > port something between 2.4 and 2.5?"  Answer: "Bk won't help - at
> > least not as much as it would help if 2.5 had been cloned from 2.4."
> 
> 2.5 _is_ cloned from 2.4..

Really?  Cool, I wonder where I got the idea it wasn't...

Even so, I can't figure out how to backport from 2.5 to 2.4 without
using patches (but Larry's smarter than I am, he might know how).
Cherry picking would only solve part of the problem, the independent
creation of what is logically the same file is a bigger problem.
Instead of making "stable" changes to the 2.4 tree and pulling them
into the dev tree, they've been independently applied to both trees.
Development on 2.4 and 2.5 would have to be more coordinated with each
other than it is right now to really take advantage of the ability to
push/pull between 2.4 and 2.5.

-VAL
