Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTA1Msu>; Tue, 28 Jan 2003 07:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTA1Msu>; Tue, 28 Jan 2003 07:48:50 -0500
Received: from ns.suse.de ([213.95.15.193]:37134 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265250AbTA1Mss>;
	Tue, 28 Jan 2003 07:48:48 -0500
Date: Tue, 28 Jan 2003 13:10:49 +0100
From: Stefan Reinauer <stepan@suse.de>
To: Raphael Schmid <raphael@arrivingarrow.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128121048.GB32488@suse.de>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
User-Agent: Mutt/1.4i
X-Message-Flag: Life is too short to use a crappy OS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Raphael Schmid <Raphael_Schmid@CUBUS.COM> [030128 10:01]:
> It is my very understanding one can not have, conveniently it should be,
> a simple *bootscreen* under Linux. With that I mean a picture of at
> least 256 (indexed) colours at a size of 640x480 pixels. Doesn't have
> to be a higher resolution. And yes, I'm taking the standpoint that every
> computer nowadays [where this shall be possible] *can* do that resolution.

It's not too much to even state that almost any computer working with
Linux 2.4+ can do 800x600 or 1024x768. Anything below that can be
considered a special case, regarding the numbers out there. But that
does not influence the possibility of using a bootsplash graphics. 
On a system you can't use it properly, you probably also would not 
want it (i.e. use normal text mode boot instead of a framebuffer
driver)
 
> Framebuffer, I hear people shouting? Well. During the last *two days*,
> which includes one full night, I've been trying to get my v2.4.20 kernel
> to display such a bootscreen. All I get is segfaults. I've tried what I
> believe to be every tool out there: pnmtologo, fblogo, boot_logo, the
> GIMP plugin. You name them. None of which wouldn't have required any
> hacking to work with 2.4.20, by the way...

Have a look at ftp.suse.com/pub/people/stepan/bootsplash/ - There you
find kernel patches, user space utilities and such to display a
bootsplash screen. You can either choose to have a picture put "behind"
your text, or have a picture _instead_ of text. (triggerable with a 
boot parameter so anybody is happy). And yes, it _does_ look cool to see
your kernel messages scrolling up on a background of a slightly faded
out penguin, looking like a water sign. ;-)

> And maybe it's right, maybe I demand too much from the (VESA) framebuffer.
> Maybe my picture is also too complex, but I've tried simple ones as well.
> And anyway: I don't *want* any simple picture, I want as complex a picture
> as it gets. In 640x480. At 256 indexed colours.
My patch above includes a small and efficient jpeg decoder (8k), which
allows you to read any jpg picture from an initrd.

> I realize these ideas may sound kind of alien to you, but they make sense.
> Windows, MacOS all have bootscreens. There really is no way why Linux
> shouldn't.
 
It's not alien, and it does make sense. I, speaking for myself, know the
kernel boot messages by heart and I don't expect them to change with the
2957596. bootup of my linux box. ;)

Any comments?

   Stefan
  
-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra
