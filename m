Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266700AbUBQWay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUBQW1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:27:48 -0500
Received: from [212.28.208.94] ([212.28.208.94]:63754 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266576AbUBQW1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:27:14 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: UTF-8 and case-insensitivity
Date: Tue, 17 Feb 2004 23:27:08 +0100
User-Agent: KMail/1.6.1
Cc: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <16433.38038.881005.468116@samba.org> <200402172208.25398.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402171314320.2154@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402171314320.2154@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402172327.08962.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 22.17, Linus Torvalds wrote:
> The fact that _I_ think pathnames are just a nice stream of bytes sadly 
> doesn't make Windows clients do the same. Some day when I'm King Of The 
> World, and I can outlaw windows clients, we'll finally get rid of the 
LPA = Linus' Patriot Act. 

> braindamage, but until then I'm pragmatic enough to say "let's help out 
> the poor samba people who have to deal with the crap day in and day out".
> 
> What's your problem with that?

Nothing wrong with helping people. 

Having to put up with the existence of Windows day in and out is the reason I'm still on
an eight-bit encoding.  Sorry for not explaining the REAL problem, but only a partial
problem. I need to support all kinds of clients on Windows with protocols that convey no
character set info. With samba that's no problem. Having to put up with a Unix world running 
ISO-8859-1 (or ISO-8859-15) is another. Ofcourse that means Linux machines also add
to the disturbance by not storing things as unicode. The real obstable is file names, 
everything else including content of files, I can handle (I think). Maybe I'll find a solution
for the filenames too, but usually some hot discussions are needed for the brain to kick
into the right gear. 

I want to switch to UTF-8 to work better with the outside world, but as things are people will 
start to take notice of what OS is running in the shadows when they see the filename problems, and 
start demanding Windows, and ...  You see; I'm not mean; I don't want to do that to them (or myself),

-- robin
