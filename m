Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbSJNUk3>; Mon, 14 Oct 2002 16:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262240AbSJNUk3>; Mon, 14 Oct 2002 16:40:29 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:28164 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id <S262235AbSJNUk1> convert rfc822-to-8bit; Mon, 14 Oct 2002 16:40:27 -0400
Subject: Re: [Linux-fbdev-devel] fbdev changes.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 22:46:17 +0200
Message-Id: <1034628378.1143.507.camel@tibook>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Son, 2002-10-13 at 22:27, James Simmons wrote: 
> 
>   The final changes to the fbdev layer are at hand. One of the last
> changes I wanted to purpose was to create a console driectory in
> drivers/video and move all console related stuff into that directory.
> The next step was to move the dri stuff into that directory with the agp
> code possible. The questions I have is should we move the agp code over to
> that directory. Should the DRI code move over directly or should we move
> DRI driver specific code into the same directory as the fbdev driver
> directories? For example in aty directory we have all the ati framebuffer
> and ATI dri code. What do you think?

Wouldn't that complicate merges between the kernel and DRI CVS? At any
rate, I think discussion related to the DRI should take place on
dri-devel.


-- 
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

