Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCFVcs>; Tue, 6 Mar 2001 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRCFVci>; Tue, 6 Mar 2001 16:32:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47622 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129524AbRCFVc2>;
	Tue, 6 Mar 2001 16:32:28 -0500
Date: Tue, 6 Mar 2001 22:31:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Message-ID: <20010306223151.W2803@suse.de>
In-Reply-To: <20010306214838.V2803@suse.de> <Pine.LNX.4.10.10103061255301.13719-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10103061255301.13719-100000@master.linux-ide.org>; from andre@linux-ide.org on Tue, Mar 06, 2001 at 12:59:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06 2001, Andre Hedrick wrote:
> > But I might want to do this (write sector 0), why would we want
> > to filter that? If someone a) uses an email client that will execute
> > java script code (or whatever) and b) runs that as root (which
> > he would have to do, surely no ordinary user has privileges to send
> > arbitrary commands) then he gets what he deserves.
> 
> Jens we are not going there....the filter is the only way known to jam
> unknown commands, and you missed the point of the issue then and I think
> you still miss it.  "arbitrary commands" + wrong hander is lock-up.

I'm perfectly aware of the handler issue. So make it part of the
user space taskfile interface in a nice way, done and done. And I
knew I shouldn't have replied to this, the last thing I want to do
is start another flamewar :-)

So EOD from me.

-- 
Jens Axboe

