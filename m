Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWCHS4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWCHS4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWCHS4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:56:50 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:20966 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932364AbWCHS4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:56:50 -0500
Message-ID: <440F28C6.6050508@comcast.net>
Date: Wed, 08 Mar 2006 13:56:06 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060307)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Sound userspace drivers (fishing for insight)
References: <440E5746.7070003@comcast.net>	<Pine.LNX.4.61.0603080939360.9337@tm8103.perex-int.cz>	<440F0396.4050905@comcast.net> <s5h8xrkepxy.wl%tiwai@suse.de>
In-Reply-To: <s5h8xrkepxy.wl%tiwai@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Takashi Iwai wrote:
> At Wed, 08 Mar 2006 11:17:26 -0500,
> John Richard Moser wrote:
>>>> into the kernel; with alsa it's written to a /proc interface, which
>>> Using /proc? Where? I've not noticed it :-)
>> I thought that was what /proc/asound/card0/ was for?  :)
> 
> /proc is not referred from alsa-lib, i.e. programs don't access them.
> It's just for users who want to read some information.
> 

This makes me wonder then how stuff is set up.  There's no device, is
there a sound card syscall now?

> 
> Takashi
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRA8oxQs1xW0HCTEFAQKGuA//RX/shtqKKPYQwSdP8O+Ai5C7VnQV+GiN
I/+OalJIjfK/zUiJP6CIsFcNxTFTPiUJOwF/MKguiwWHsMwr/CWu/MVqAQEDC/yP
UO1hSLcGKTp8xHh5jSIyotjisXaGx8rSq0Ye8ZDGPgDlVXb27USkmqWwySBCO+OJ
pFtzGy9GxuJ+1OWoiXd0ytTSVm6WPEX/zFNsQmY4AnFid5aTrlxjDjQpx2cxt4iq
j1nc+kkt450m4y233Cuncb7UXI/WzVhUX89dJf4RkjMKs5QDBvtQhzTB4K3PPByg
l13xQq8si/knA8jcYcEbtHrzh+bTlvSwa8hJfONG3tbShHedJNQA+kLm6zpwm/kw
hGkW0/IYU/Kpxh6Hg8yqb67ibbLFKjNc0njwRTZ5CLkE4pUwT/NASY4j5IcXYMrp
bOla+ASuy/g0dYngmh0wK4tqJJSfl+SdZt+AkeVm6x5XtYv2k2uEhfQsDWpqhp0z
TXiauuLhdJZ3mle21ZcY634Ws9C2vLmH6/TBQAgb0azryo9W4FQvEfPszbPyln04
irNC/VkKQ9vDr3spjXlqW9hCCD176+uOoHsI79WnUiz1EUdQ02kZ4mLm/i4JuXS8
Y8rezaHx7iypylVlI7c5CaDuEnrsBfvX7i/FqUa3/E0yH0v2wU0EcmC2K1OF1d7M
q0jA3aTHj+o=
=wEi9
-----END PGP SIGNATURE-----
