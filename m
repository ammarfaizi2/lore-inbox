Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVE3JJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVE3JJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVE3JJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:09:45 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:35541 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261567AbVE3JJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:09:39 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 May 2005 11:07:57 +0200
To: schilling@fokus.fraunhofer.de, dtor_core@ameritech.net
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429AD7ED.nail4ZG1B42TI@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
 <4295005F.nail2KW319F89@burner>
 <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
 <4296EADA.nail3L111R0J3@burner>
 <d120d500050527072146c2e5ee@mail.gmail.com>
In-Reply-To: <d120d500050527072146c2e5ee@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > Cdrecord includes the needed features to do what you like, but do not
> > asume that you will be able to force me to make nonportable and Linux
> > specific interfaces a gauge for the design of a portable program.
> > If you read the cdrecord man page, you know that you could
> > happily call cdrecord dev=green_burner.....
> > 
>
> No, that static mapping is not good. I have an external enclosure that
> does firewire and USB. I want to be able to use "sony-dvd" to access
> it no matter whether it is onnected to USB bus or Firewire and whether
> there are other devices (disks) on USB or firewire. It is possible to
> do with udev creating a link to /dev/sony-dvd.

I am not sure what you like to do.....

But what you claim is simply impossible.

As you started to introduce the allegory with the colors, let me make 
an assumption based on your claim:

-	Buy two identical drives and varnish one in red and the other 
	in green.

-	Connect both drives to your computer to let the OS "learn" the
	drives.

-	Do any setup you like

-	Now disconnect the drives and after that, connect the green one
	the way the red one has been connected before. 

-	Connect the red one too.

-	Insert a medium into the green drive

-	Let your software try whether it is able to connect you
	to the green one.

If this always works as expected, then you are a magician!

So let me sum up: Never rely on things that cannot be made 100%
unique in case you like to run security relevent software like cdrecord.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
