Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbTALJUq>; Sun, 12 Jan 2003 04:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268265AbTALJUp>; Sun, 12 Jan 2003 04:20:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18438 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267342AbTALJTV>;
	Sun, 12 Jan 2003 04:19:21 -0500
Date: Sun, 12 Jan 2003 01:27:06 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112092706.GN30025@kroah.com>
References: <20030110161012.GD2041@holomorphy.com> <1042219147.31848.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042219147.31848.65.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 05:19:08PM +0000, Alan Cox wrote:
> The entire tty layer locking is terminally broken and nobody has even
> started fixing it. Just try a mass of parallel tty/pty activity . It
> was problematic before, pre-empt has taken it  to dead, defunct and
> buried. 

I've looked into this, and wow, it's not a simple fix :(

But this is really the first it's been mentioned, I can't see holding up
2.6 for this.  It's a 2.7 job at the earliest, unless someone wants to
step up and do it right now...

thanks,

greg k-h
