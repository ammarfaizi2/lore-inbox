Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTJTIXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTJTIXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:23:07 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:3850 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262262AbTJTIXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:23:02 -0400
Date: Mon, 20 Oct 2003 01:22:58 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in
Message-ID: <20031020082258.GE7328@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com> <3F924660.4040405@namesys.com> <20031019083551.GA1108@holomorphy.com> <20031019224952.GA7328@pegasys.ws> <200310200722.h9K7Mxkm000371@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310200722.h9K7Mxkm000371@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may cause mental anguish to the close-minded. Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 08:22:59AM +0100, John Bradford wrote:
> > What is apparently missing is better handling of the
> > uncorrectable errors.  Specifically the ability to pass the
> > errors and warnings up to the OS for evaluation and for the
> > OS to be able to request a block remap or to undo a block
> > remap.
> 
> Why this suggestion keeping coming up, I have no idea.  If you take
> the idea to it's extreme, it's basically saying that we should
> off-load all processing on to the host.  Although there has been a
> move towards dumb peripherals in recent years, (E.G. software modems),
> I have seen almost no even vaguely convincing arguments other than
> cost as to why they are superior, (lower latency has been mentioned
> with regard to software modems - I fail to see the benefit, although I
> suppose it might exist for games players).  Apart from some data
> recovery applications, I don't see how it is possible to do anything
> really useful simply by adding the ability to pass some warnings and
> errors up to the OS, without giving the OS access to all of the data
> that the drive firmware has access to.

I'm not suggesting the drive off-load it.  I'm only
suggesting that there be a mechanism for the host to be more
involved if the host is capable.

The problem that began this thread is a perfect example.  A
bad block that the drive firmware apparently will not remap
calls for the ability to explicitly instruct the drive to
remap it.  In some cases it might be good to be able to let
the host countermand a remap if the disk reports overtemp.

> Obviously drives with completely open and free firmware would be
> great, but that is not likely to happen in the near future, so for the
> time being, if you don't like the way drives handle defect management,
> complain to the manufactuers.  I am satisfied with the way Maxtor
> disks handle defect management, both Eric's explainations and my own
> observations.

No disagreement here.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
