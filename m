Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWAWRAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWAWRAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWAWRAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:00:14 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:58647 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964814AbWAWRAM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:00:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VD42iZn0SynzUWH8jkPvcIw+zzegYRuRNVrJlMRU/dy/BfTQrRet6V1Dajh+OzQy7mTHsbDD2I1JchNn341vzp+VhOA32kcGnBB26V46rgzpIwMYath5rg/DobBwgTXtVUY7XWg2rFqiizovtQWvOlPhYKJJPM26QT4YnPoNK+0=
Message-ID: <84144f020601230900x477dd21am8d94f382e37c5072@mail.gmail.com>
Date: Mon, 23 Jan 2006 19:00:09 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Linux VFS architecture questions
Cc: Antonio Vargas <windenntw@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <CEED5F58-EF3D-44D9-9C54-FE1720640E11@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org>
	 <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org>
	 <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com>
	 <20060123072447.GA8785@thunk.org>
	 <536E71BF-44FF-430C-8C19-F06526F0C78D@mac.com>
	 <69304d110601230552n4c7656cal9c6901e180e82504@mail.gmail.com>
	 <CEED5F58-EF3D-44D9-9C54-FE1720640E11@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

On 1/23/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> Great!  I'm trying to learn about filesystem design and
> implementation, which is why I started writing my own hfsplus
> filesystem (otherwise I would have just used the in-kernel one).  Do
> you have any recommended reading (either online or otherwise) for
> someone trying to understand the kernel's VFS and blockdev
> interfaces?  I _think_ I understand the basics of buffer_head,
> super_block, and have some idea of how to use aops, but it's tough
> going trying to find out what functions to call to manage cached disk
> blocks, or under what conditions the various VFS functions are
> called.  I'm trying to write up a "Linux Disk-Based Filesystem
> Developers Guide" based on what I learn, but it's remarkably sparse
> so far.

Did you read Documentation/filesystems/vfs.txt? Also, books Linux
Kernel Development and Understanding the Linux Kernel have fairly good
information on VFS (and related) stuff.

                      Pekka
