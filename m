Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbSJEXkY>; Sat, 5 Oct 2002 19:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJEXkY>; Sat, 5 Oct 2002 19:40:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16903 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262814AbSJEXkW>; Sat, 5 Oct 2002 19:40:22 -0400
Date: Sat, 5 Oct 2002 16:47:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Maksim (Max)  Krasnyanskiy" <maxk@qualcomm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK 1/6] 2.5.x Bluetooth subsystem update. Core.
In-Reply-To: <1033856154.6656.87.camel@champ.qualcomm.com>
Message-ID: <Pine.LNX.4.44.0210051638440.1587-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Oct 2002, Maksim (Max)  Krasnyanskiy wrote:
> 
> You can either pull all of them from:
> 	bk://linux-bt.bkbits.net/bt-2.5

Ok, pulled. But _please_ do this the regular way next time. There's even a 
script to help you do it in linux/Documentation/BK-usage/bk-mak-sum, which 
does it all for you for BK patches.

(many people end up doing their own thing, you don't have to use that
particular script, of course. But the important thing I want is that the
_email_ should contain enough information to make a good first pass
judgement on what the patch does, and in particular it is important for me
to see what a "bk pull" will actually change.)

That's why the "diffstat" is important to me if I do a BK pull - and why I 
want to see the patches as plaintext if I apply stuff to generic files.. 

So:
 - if you use BK (which is great - your tree looked fine and the only real 
   problem was that I had to verify it separately by hand first), please 
   send one email for the "bk pull", and include a diffstat for the whole 
   thing in that one email.

 - if you use patches, please send them as clear-text in the email itself, 
   and don't think that I want to go fetch them separately from some other 
   site.

For optimal exposure, do both - this is what Greg KH does for USB stuff
(he sends the BK email to me and to the kernel list, and sends individual
patches to the kernel list only). Which really helps the people who don't
want to use BK for some reason.

			Linus


