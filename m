Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319151AbSHTDeB>; Mon, 19 Aug 2002 23:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319152AbSHTDeA>; Mon, 19 Aug 2002 23:34:00 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:48912 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319151AbSHTDeA>;
	Mon, 19 Aug 2002 23:34:00 -0400
Date: Mon, 19 Aug 2002 20:32:55 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
Message-ID: <20020820033254.GA26331@kroah.com>
References: <Pine.LNX.4.44.0208191111100.1048-100000@cherise.pdx.osdl.net> <3D6113E1.302@netscape.net> <20020819195909.GA24488@kroah.com> <3D61691B.7080409@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D61691B.7080409@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 23 Jul 2002 02:23:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 09:54:35PM +0000, Adam Belay wrote:
> By the way, is diethotplug a space efficient binary version of the
> hotplug scripts or is there more to it then that?

Yes it is a space efficient version (the resulting binary is usually
300% smaller than the original modules.*map files being used.)  It
achieves these space savings at the expense of flexibility, the binary
is always tied to a specific kernel version.

Embedded and rescue disk distros are using the program, as a replacement
for the hotplug scripts, but the primary purpose is for the program to
live in initramfs and be used as part of the normal kernel boot process.

thanks,

greg k-h
