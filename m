Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266354AbUALQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266406AbUALQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:01:25 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:30102 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266354AbUALQBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:01:22 -0500
Date: Tue, 13 Jan 2004 00:01:26 +0800 (WST)
From: raven@themaw.net
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <40029C19.409@sun.com>
Message-ID: <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
 <40029C19.409@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Mike Waychison wrote:

> >
> >Transparency of an autofs filesystem (as I'm calling it) is the situation
> >where, given a map
> >
> >/usr	/man1	server:/usr/man1
> >	/man2	server:/usr/man2
> >
> >where the filesystem /usr contains, say a directory lib, that needs to be
> >available while also seeing the automounted directories.
> >
> >  
> >
> I see.  This requires direct mount triggers to do properly.  Trying to 
> do it with some sort of passthrough to the underlying filesystem is a 
> nightmare waiting to happen..
> 

So what are we saying here?

We install triggers at /usr/man1 and /usr/man2.
Then suppose the map had a nobrowse option.
Does the trigger also take care of hiding man1 and man2?

Is there some definition of these triggers?

Ian

