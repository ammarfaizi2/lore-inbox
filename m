Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTLQSUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLQSUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:20:43 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:41097 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264442AbTLQSUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:20:42 -0500
Date: Wed, 17 Dec 2003 10:20:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthias Andree <matthias.andree@gmx.de>,
       Dick Johnson <root@chaos.analogic.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [Answer] Re: Linux 2.4.24-pre1: Instant reboot
Message-ID: <20031217182010.GF1402@matchmail.com>
Mail-Followup-To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthias Andree <matthias.andree@gmx.de>,
	Dick Johnson <root@chaos.analogic.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <3FDF63A2.9090205@enterprise.bidmc.harvard.edu> <20031216223833.GC12564@merlin.emma.line.org> <1071641243.5423.27.camel@ktkhome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071641243.5423.27.camel@ktkhome>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 01:07:21AM -0500, Kristofer T. Karas wrote:
> If I didn't have 2 hours sleep, I would have hacked rc.sysinit to
> auto-compile my linux kernel with a binary search looking for the
> culprit, iterating if the BIOS rebooted an old kernel; but I was too
> tired today for scriping foo.  :-)  So I did it the old fashioned way.

I think you would have had to do it manually anyway.  Your boot didn't even
get to the point of loading userspace, so you would have been indefinately
one kernel.
