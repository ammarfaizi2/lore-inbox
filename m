Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbRETObh>; Sun, 20 May 2001 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbRETOb2>; Sun, 20 May 2001 10:31:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43981 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261638AbRETObP>;
	Sun, 20 May 2001 10:31:15 -0400
Date: Sun, 20 May 2001 10:31:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device
 Num
Message-ID: <Pine.GSO.4.21.0105201030550.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Tim Jansen wrote:

> That's why I proposed using multi-stream files. With a syscall like
> 
> fd2 = open_substream(fd, "somename")

You also have "streams" thay are related to many device nodes at once. Sorry.

> you could have several control streams and also be prepared if you want to 
> support multi-stream filesystems like NTFS in the future...

Let's _not_ bring that into this thread, OK?


