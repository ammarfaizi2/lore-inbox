Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268846AbTCCWva>; Mon, 3 Mar 2003 17:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268847AbTCCWva>; Mon, 3 Mar 2003 17:51:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:55034 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268846AbTCCWvN>;
	Mon, 3 Mar 2003 17:51:13 -0500
Date: Mon, 3 Mar 2003 14:57:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Horrible L2 cache effects from kernel compile
Message-Id: <20030303145750.14de1160.akpm@digeo.com>
In-Reply-To: <1046735907.7947.0.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0303031108390.12011-100000@home.transmeta.com>
	<1046735907.7947.0.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 23:01:35.0239 (UTC) FILETIME=[D6C7A970:01C2E1D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Mon, 2003-03-03 at 19:13, Linus Torvalds wrote:
> > dentry itself. Yes, you could make it smaller (you could remove the inline
> > string from it, for example, and you could avoid allocating it at
> 
> How about at least making the inline string align to the slab alignment so we
> dont waste space ?

That change was made a couple of months back.
