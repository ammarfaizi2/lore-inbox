Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132788AbRDQRwH>; Tue, 17 Apr 2001 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132798AbRDQRv5>; Tue, 17 Apr 2001 13:51:57 -0400
Received: from www.transvirtual.com ([205.217.46.36]:8965 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S132788AbRDQRvj>; Tue, 17 Apr 2001 13:51:39 -0400
Date: Tue, 17 Apr 2001 10:51:06 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Guest section DW <dwguest@win.tue.nl>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
Message-ID: <Pine.LNX.4.10.10104171044020.2508-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> this for embedded devices. It just plain stupid to have VT support on
>> something like a hand held iPAQ which doesn't usually have a keyboard
>> attached. Also having fbcon built in for these devices just takes up
>
>It makes plenty of sence to have support for virtual terminals on the
>ipaq. I agree you want it modular so you can load the vt support when you
>need it.

Only if you have the attachable keyboard. Other embedded devices
completely lack a keyboard. They do however have some graphical output.
If you want X on them then using the /dev/input/event interface is the way
to go. I like to see that for the desktop as well :-)  

