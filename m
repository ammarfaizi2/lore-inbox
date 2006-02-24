Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWBXTAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWBXTAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWBXTAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:00:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40394 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932274AbWBXTAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:00:04 -0500
Date: Fri, 24 Feb 2006 12:56:32 -0600
From: Robin Holt <holt@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, John McCutchan <john@johnmccutchan.com>,
       holt@sgi.com, linux-kernel@vger.kernel.org, rml@novell.com,
       arnd@arndb.de, hch@lst.de, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: udevd is killing file write performance.
Message-ID: <20060224185632.GB343@lnx-holt.americas.sgi.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com> <1140626903.13461.5.camel@localhost.localdomain> <20060222175030.GB30556@lnx-holt.americas.sgi.com> <1140648776.1729.5.camel@localhost.localdomain> <20060222151223.5c9061fd.akpm@osdl.org> <1140651662.2985.2.camel@localhost.localdomain> <20060223161425.4388540e.akpm@osdl.org> <20060224054724.GA8593@johnmccutchan.com> <20060223220053.2f7a977e.akpm@osdl.org> <43FEB0BF.6080403@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FEB0BF.6080403@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 06:07:43PM +1100, Nick Piggin wrote:
> Attached is a first implementation of what was my idea then of how
> to solve it... note it is pretty rough and I never got around to doing
> much testing of it.
> 
> Basically: moves work out of inotify event time and to inotify attach
> /detach time while staying out of the core VFS.

The customer called and said they had tried with udevd running and this
patch applied.  They said the problem is gone.

Thanks,
Robin Holt
