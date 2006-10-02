Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWJBUfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWJBUfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWJBUfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:35:41 -0400
Received: from 1wt.eu ([62.212.114.60]:5124 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S964998AbWJBUfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:35:40 -0400
Date: Mon, 2 Oct 2006 22:35:27 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Lang <dlang@digitalinsight.com>
Cc: Phillip Susi <psusi@cfl.rr.com>,
       Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20061002203527.GA585@1wt.eu>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz> <45212D5D.7010201@cfl.rr.com> <Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz> <45217498.8060806@cfl.rr.com> <Pine.LNX.4.63.0610021310150.28876@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610021310150.28876@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 01:12:55PM -0700, David Lang wrote:
> no, I was suggesting a pack file that contained _only_ the head version.
> 
> within the pack file it would delta against other files in the pack (how 
> many copies of the GPLv2 text exist across all files for example)
> 
> however Willy did a test and found that the resulting pack was 
> significantly larger then a .tgz. I don't know what options he used, so 
> while there's some chance that being more agressive in looking for deltas 
> would result in an improvement, the difference to make up is fairly 
> significant.

no options at all, so there may be room for improvement. Also, on my
notebook, I have hardlinked all my linux directories so that each
content only appears once. I don't have the numbers right here, but
I remember that it was really useful to merge lots of different versions,
but that the net gain within one given tree was really minor, as there
are not that many identical files in one tree.

Regards,
Willy

