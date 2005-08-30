Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVH3Qgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVH3Qgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVH3Qgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:36:42 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:34024 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932236AbVH3Qgk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:36:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O1wKRZ7ERnofbcIYdTJLxJHpglfbhb1oQuWnNyEf7ClPYXC0B8LtErCD5nNg08jeHNEDR+jra868XFYmt7IXH4Dq8WbJ5oL5K5cT0VDwJSSexVvB8lzyMya5elLbudzHq3SaHuhbg55EWjNcLcbU1YtdQxq7kGJmpixT3c2FS/4=
Message-ID: <9a87484905083009365ff30119@mail.gmail.com>
Date: Tue, 30 Aug 2005 18:36:33 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Cc: Andrea Arcangeli <andrea@suse.de>, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       Sven Ladegast <sven@linux4geeks.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1125419618.8276.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830030959.GC8515@g5.random>
	 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
	 <20050830082901.GA25438@bitwizard.nl>
	 <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de>
	 <20050830094058.GA29214@bitwizard.nl>
	 <20050830151035.GO8515@g5.random>
	 <1125419618.8276.30.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-08-30 at 17:10 +0200, Andrea Arcangeli wrote:
> > It's certainly much easier to tweak the kernel config before compiling
> > the kernel than to edit the mess in /etc/init.d/* with all the
> > gratuitous differences of the userland flavours.
> 
> Just follow the LSB specification and about the only thing thats totally
> out of field is Slackware.
> 
These days Slackware has /etc/rc.d/rc.sysvinit to run SystemV style
init scripts in addition to its own BSD init scripts. So as long as
the script is well written (takes start/stop arguments) and is placed
in /etc/rc.d/rc${runlevel}.d/ as both K* and S*, then all a slackware
user needs to do to run it at boot is to  chmod +x
/etc/rc.d/rc.sysvinit  if they haven't already.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
