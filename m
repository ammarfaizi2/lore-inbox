Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTBFJam>; Thu, 6 Feb 2003 04:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTBFJam>; Thu, 6 Feb 2003 04:30:42 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:56582 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265854AbTBFJak>; Thu, 6 Feb 2003 04:30:40 -0500
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0302061017330.3301-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0302061017330.3301-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1044437021.1169.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Feb 2003 17:24:22 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 17:19, Geert Uytterhoeven wrote:
> 
> I always see the logo twice. The first time it's erased by the text (because
> initially fbcon thinks logo_height = 0), the second time it's displayed
> correctly.
> 
> So I also wondered why it's drawn twice?

I was expecting this behavior because I remember you mentioning it in
one of your early mails.  In my case, it was only drawn once which
lasted only for a blink.

> > Overall, I like it, though it does add some kilobytes to the kernel
> > image size.
> 
> Why would it increase kernel size that much? The logos were there before as
> well (unless you enable all of them, of course :-).
> 
My fault, I accidentally enabled ACPI :-)

Tony


