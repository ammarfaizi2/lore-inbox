Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284831AbSAGTI7>; Mon, 7 Jan 2002 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbSAGTIt>; Mon, 7 Jan 2002 14:08:49 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:12555 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284831AbSAGTIk>;
	Mon, 7 Jan 2002 14:08:40 -0500
Date: Mon, 7 Jan 2002 11:06:43 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020107190643.GA8413@kroah.com>
In-Reply-To: <20020107185001.GK7378@kroah.com> <Pine.LNX.4.33.0201071956410.16327-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201071956410.16327-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 16:58:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 07:58:49PM +0100, Dave Jones wrote:
> which reminds me of another initramfs issue. I noticed you included
> dietlibc in the diethotplug (hence the name I guess), but has any
> decision been made yet as to what's going to be chosen as an
> initlibc/klibc ?

I don't know.  I asked the dietLibc people if they would be willing to
create a stripped down version of it and help port it to the remaining
archs that Linux supports, but dietLibc doesn't, and didn't hear
anything back.

It doesn't look like much work to do the stripping (I did a bunch of it
for the latest version of dietHotplug) but the porting, I have no idea
of what is needed there.

Anyone want to start up a klibc project? :)

greg k-h
