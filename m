Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWJCDWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWJCDWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 23:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJCDWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 23:22:14 -0400
Received: from 1wt.eu ([62.212.114.60]:6404 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1750898AbWJCDWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 23:22:13 -0400
Date: Tue, 3 Oct 2006 04:48:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sean <seanlkml@sympatico.ca>
Cc: David Lang <dlang@digitalinsight.com>, Phillip Susi <psusi@cfl.rr.com>,
       Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20061003024852.GA11775@1wt.eu>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz> <45212D5D.7010201@cfl.rr.com> <Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz> <45217498.8060806@cfl.rr.com> <Pine.LNX.4.63.0610021310150.28876@qynat.qvtvafvgr.pbz> <20061002203527.GA585@1wt.eu> <20061002174938.bb82027d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002174938.bb82027d.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 05:49:38PM -0400, Sean wrote:
> On Mon, 2 Oct 2006 22:35:27 +0200
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > On Mon, Oct 02, 2006 at 01:12:55PM -0700, David Lang wrote:
> > > no, I was suggesting a pack file that contained _only_ the head version.
> > > 
> > > within the pack file it would delta against other files in the pack (how 
> > > many copies of the GPLv2 text exist across all files for example)
> > > 
> > > however Willy did a test and found that the resulting pack was 
> > > significantly larger then a .tgz. I don't know what options he used, so 
> > > while there's some chance that being more agressive in looking for deltas 
> > > would result in an improvement, the difference to make up is fairly 
> > > significant.
> > 
> > no options at all, so there may be room for improvement. Also, on my
> > notebook, I have hardlinked all my linux directories so that each
> > content only appears once. I don't have the numbers right here, but
> > I remember that it was really useful to merge lots of different versions,
> > but that the net gain within one given tree was really minor, as there
> > are not that many identical files in one tree.
> 
> Hey Willy,
> 
> I don't really understand the objective here, but you may want to double
> check your procedure, the entire 2.4 history only takes a single 41M pack
> in Git for me.

I'm not really surprized, as GIT history begins at 2.4.32 and recent
2.4 patches are very small. So basically, the size is about the same
for the latest 2.4 and all 2.4 history.

Willy

