Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUAHEYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 23:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbUAHEYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 23:24:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:45544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263702AbUAHEXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 23:23:43 -0500
Date: Wed, 7 Jan 2004 20:23:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Olaf Hering <olh@suse.de>, Greg KH <greg@kroah.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <200401072316.18169.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0401072019040.2131@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040107205237.GB16832@suse.de>
 <Pine.LNX.4.58.0401071801310.12602@home.osdl.org> <200401072316.18169.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Gene Heskett wrote:
> 
> I do too, except the card is still in my camera when I do it.

My camera just does USB-1, and with a gigabyte card that's just too 
painful. Besides, I don't want to eat camera batteries. So I just pop it 
over in something that is ten times faster.

> But, I do have to ask, why the ro?

I don't trust camera firmware to do a full VFAT implementation, so out of 
principle I only let the camera write to it normally. That way I don't 
need to worry about the limited braincapacity of my poor camera.

> Apparently fat thinks an empty sector is the end of the directory.  So
> one must delete on LIFO basis.

Sounds like your camera gets easily confused too. Me, I just transfer the 
whole thing, and then I let the camera do a "format". 

I've seen cameras that have serious problems with old filesystems - when 
they get fragmented enough, the camera says that there is 50% free space, 
but can't actually write a single picture any more. Deleting pictures to 
make space only helps a bit, then it's "full" again.

Which is why I just delete everything by letting the camera do the
formatting. 

Some day cameras will run Linux too, and I'll trust them. In the meantime 
I just don't expect them to do that well.

		Linus
