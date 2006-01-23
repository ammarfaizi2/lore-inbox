Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWAWRyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWAWRyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWAWRyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:54:20 -0500
Received: from xenotime.net ([66.160.160.81]:4247 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964852AbWAWRyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:54:19 -0500
Date: Mon, 23 Jan 2006 09:54:15 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Antonio Vargas <windenntw@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux VFS architecture questions
In-Reply-To: <A31CA9FF-4B56-483C-8BCC-CECD9B812844@mac.com>
Message-ID: <Pine.LNX.4.58.0601230953300.28316@shark.he.net>
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org>
 <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org>
 <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com> <20060123072447.GA8785@thunk.org>
 <536E71BF-44FF-430C-8C19-F06526F0C78D@mac.com>
 <69304d110601230552n4c7656cal9c6901e180e82504@mail.gmail.com>
 <CEED5F58-EF3D-44D9-9C54-FE1720640E11@mac.com>
 <84144f020601230900x477dd21am8d94f382e37c5072@mail.gmail.com>
 <A31CA9FF-4B56-483C-8BCC-CECD9B812844@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Kyle Moffett wrote:

> On Jan 23, 2006, at 12:00, Pekka Enberg wrote:
> > Hi Kyle,
> >
> > On 1/23/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> >> Great!  I'm trying to learn about filesystem design and
> >> implementation, which is why I started writing my own hfsplus
> >> filesystem (otherwise I would have just used the in-kernel one).
> >> Do you have any recommended reading (either online or otherwise)
> >> for someone trying to understand the kernel's VFS and blockdev
> >> interfaces?  I _think_ I understand the basics of buffer_head,
> >> super_block, and have some idea of how to use aops, but it's tough
> >> going trying to find out what functions to call to manage cached
> >> disk blocks, or under what conditions the various VFS  functions
> >> are called.  I'm trying to write up a "Linux Disk-Based Filesystem
> >> Developers Guide" based on what I learn, but it's remarkably
> >> sparse so far.
> >
> > Did you read Documentation/filesystems/vfs.txt?
>
> Yeah, that was the first thing I looked at.  Once I've got things
> figured out, I'll probably submit a fairly hefty patch to that file
> to add additional documentation.
>
> > Also, books Linux Kernel Development and Understanding the Linux
> > Kernel have fairly good information on VFS (and related) stuff.
>
> Ah, thanks again!  It looks like both of those are available through
> my university's Safari/ProQuest subscription (http://
> safari.oreilly.com/), so I'll take a look right away!

This web page is terribly out of date, but you might find
a few helpful link on it (near the bottom):
  http://www.xenotime.net/linux/linux-fs.html

-- 
~Randy
