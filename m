Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312896AbSDGBdo>; Sat, 6 Apr 2002 20:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDGBdn>; Sat, 6 Apr 2002 20:33:43 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:32150 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S312896AbSDGBdm>; Sat, 6 Apr 2002 20:33:42 -0500
Subject: Re: more on 2.4.19pre... & swsusp
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brian@worldcontrol.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16tz9Q-0002sH-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 20:33:27 -0500
Message-Id: <1018143212.8480.99.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 17:59, Alan Cox wrote:
> > On a different note.  Why doesn't the ac branch have ftpfs yet?  Besides
> > the fact that it sometimes has problems with ls'ing a directory because
> 
> Because its perfectly doable in user space. Its for testing useful stuff not
> a dumping ground
> -



Wouldn't that be true of any networked filesystem?  They should all be
able to be done in userspace.  The problem with that would be it loses
it's transparency to the user and increases latency.  Sure ftpfs can be
done in userspace, but the point of it is so i dont have to interface
with ftp's through a specific client.  I'm sure people would love it if
they had to open samba-view whenever they wanted to copy to and from
samba shares, same for nfs etc.  

There are more than a couple examples of things in the kernel that can
also be completely functional just done in userspace,  Both autofs (why
we continue to ship an older version when the newer one is reverse
compat is a mystery to me) implementations are two such examples.  

I have nothing against not including something for personal preferences
( it is your branch) or because something is too untested.. but because
it can be done in userspace just doesn't hold up when you look at some
of the things in the kernel already.   But i've wasted enough time
arguing about something that doesn't require any changes. heh 

