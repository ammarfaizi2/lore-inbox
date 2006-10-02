Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965433AbWJBVtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965433AbWJBVtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965436AbWJBVtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:49:42 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:20938 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S965433AbWJBVtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:49:41 -0400
Message-ID: <BAYC1-PASMTP060E41BEECF96499D4A89EAE1F0@CEZ.ICE>
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Mon, 2 Oct 2006 17:49:38 -0400
From: Sean <seanlkml@sympatico.ca>
To: Willy Tarreau <w@1wt.eu>
Cc: David Lang <dlang@digitalinsight.com>, Phillip Susi <psusi@cfl.rr.com>,
       Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
Message-Id: <20061002174938.bb82027d.seanlkml@sympatico.ca>
In-Reply-To: <20061002203527.GA585@1wt.eu>
References: <20061002033511.GB12695@zimmer>
	<20061002033531.GA5050@1wt.eu>
	<Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz>
	<45212D5D.7010201@cfl.rr.com>
	<Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz>
	<45217498.8060806@cfl.rr.com>
	<Pine.LNX.4.63.0610021310150.28876@qynat.qvtvafvgr.pbz>
	<20061002203527.GA585@1wt.eu>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2006 21:52:41.0578 (UTC) FILETIME=[15A7CCA0:01C6E66D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 22:35:27 +0200
Willy Tarreau <w@1wt.eu> wrote:

> On Mon, Oct 02, 2006 at 01:12:55PM -0700, David Lang wrote:
> > no, I was suggesting a pack file that contained _only_ the head version.
> > 
> > within the pack file it would delta against other files in the pack (how 
> > many copies of the GPLv2 text exist across all files for example)
> > 
> > however Willy did a test and found that the resulting pack was 
> > significantly larger then a .tgz. I don't know what options he used, so 
> > while there's some chance that being more agressive in looking for deltas 
> > would result in an improvement, the difference to make up is fairly 
> > significant.
> 
> no options at all, so there may be room for improvement. Also, on my
> notebook, I have hardlinked all my linux directories so that each
> content only appears once. I don't have the numbers right here, but
> I remember that it was really useful to merge lots of different versions,
> but that the net gain within one given tree was really minor, as there
> are not that many identical files in one tree.

Hey Willy,

I don't really understand the objective here, but you may want to double
check your procedure, the entire 2.4 history only takes a single 41M pack
in Git for me.

Sean
