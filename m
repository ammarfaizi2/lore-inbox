Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVBYAOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVBYAOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVBYAL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:11:56 -0500
Received: from smtp09.auna.com ([62.81.186.19]:39091 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262609AbVBYAGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:06:24 -0500
Date: Fri, 25 Feb 2005 00:06:15 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-rc4-mm1
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
References: <20050223014233.6710fd73.akpm@osdl.org>
	<1109198320l.7018l.0l@werewolf.able.es>
	<200502231812.07882.tomlins@cam.org>
	<200502231840.06017.dtor_core@ameritech.net>
In-Reply-To: <200502231840.06017.dtor_core@ameritech.net> (from
	dtor_core@ameritech.net on Thu Feb 24 00:40:05 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1109289975l.6462l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.24, Dmitry Torokhov wrote:
> On Wednesday 23 February 2005 18:12, Ed Tomlinson wrote:
> > On Wednesday 23 February 2005 17:38, J.A. Magallon wrote:
> > > 
> > > On 02.23, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
> > > > 
> > > > 
> > > > - Various fixes and updates all over the place.  Things seem to have slowed
> > > >   down a bit.
> > > > 
> > > > - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
> > > >   material, please tell me.
> > > > 
> > > 
> > > Two points:
> > > 
> > > - I lost my keyboard :(. USB, but plugged into PS/2 with an adapter.
> > 
> > Mine too.  Details sent in another message...
> > 
> 
> Does i8042.nopnp help?
> 

Yes, that makes things work.
Even better than ever before, now an USB mouse and a PS/2 logitech
trackball work fine both at the same time. In console and in X.
In previous kernels PS/2 was dead or jumped heavily when an usb mouse
was plugged. The keyboard works both in PS/2 (with adapter) and in USB.

Now a tricky question: the mouse and the trackball move the pointer in X
at different speeds. Is there any way to tell the kernel they have
the same DPI ? Or can I tweak the speed/DPI settings for them separately
to get a more or less similar movement ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam11 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


