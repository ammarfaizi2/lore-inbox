Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTDKMR4 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 08:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTDKMR4 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 08:17:56 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:11622
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264338AbTDKMR4 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 08:17:56 -0400
Date: Fri, 11 Apr 2003 08:22:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: John Bradford <john@grabjohn.com>
cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] first try for swap prefetch
In-Reply-To: <200304111221.h3BCLiHv000820@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.50.0304110819180.540-100000@montezuma.mastecende.com>
References: <200304111221.h3BCLiHv000820@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, John Bradford wrote:

> Actually, it could potentially do something very useful - if you are
> using a laptop, or other machine where disks are spun down to save
> power, you might be swapping in data while the disk still happens to
> be spinning, rather than letting it spin down, then having to spin it
> up again - in that instance you are definitely gaining something,
> (more battery life).

That sounds like a rather short disk spin down time (in which case you 
might not be gaining all that much battery life given the constant spin 
up/down), either that or you're paging in way too much stuff.

	Zwane
