Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261734AbTCGTdE>; Fri, 7 Mar 2003 14:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbTCGTdE>; Fri, 7 Mar 2003 14:33:04 -0500
Received: from terminus.zytor.com ([63.209.29.3]:7059 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id <S261734AbTCGTdD>;
	Fri, 7 Mar 2003 14:33:03 -0500
Message-ID: <3E68F623.4020701@zytor.com>
Date: Fri, 07 Mar 2003 11:42:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303070928560.26430-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0303070928560.26430-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> Correct me, IANAL, but my understanding is that klibc will be dual 
> GPL/<whatever it is now> by inclusion into the kernel tree, after all the 
> whole purpose is to provide an initramfs which will be linked into vmlinux 
> (Yes, linked not in the normal sense, but still). 
> 

I don't actually think dual licensing is necessary, since the new 
BSD/MIT license is generally considered to be GPL-compatible (i.e. it 
grants all the rights the GPL does.)  The dual license concept dates 
back to the "old BSD" license, which definitely was *not* GPL-compatible.

> So it'd rather be similar to some parts of the kernel which are already
> dual licensed (parts of ACPI I think being the latest example), and
> patches will be assumed to be contributed under that dual license, unless
> explicitly stated otherwise.

This is pretty much it, except I believe explicit dual licensing is 
superfluous.  If anyone has evidence to the contrary please let me know.

	-hpa

