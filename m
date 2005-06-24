Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbVFXRDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbVFXRDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbVFXRDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:03:03 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:33678 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263163AbVFXQ7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:59:44 -0400
Date: Fri, 24 Jun 2005 12:59:57 -0400
From: Frank Peters <frank.peters@comcast.net>
To: linux-kernel@vger.kernel.org
Cc: mkrufky@m1k.net
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050624125957.238204a4.frank.peters@comcast.net>
In-Reply-To: <42BC306A.1030904@m1k.net>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005 12:10:18 -0400
Michael Krufky <mkrufky@m1k.net> wrote:

> I am having the same problem with my Shuttle FT61 motherboard, although 
> I have not tried to disable ACPI... Until now I thought I just had a 
> faulty keyboard, as my method to fix this was to unplug the keyboard and 
> plug it back in after bootup.  When this happens, I see this in dmesg as 
> the last line:
> 
> input: AT Translated Set 2 keyboard on isa0060/serio0
> 
> I am also having problems with my AUX mouse, as seen in message
> 
> Subject: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
> 
> Frank, are you having problems with your ps/2 mouse port as well?
> 

I am so glad that you asked this.

I have not been able to get my ps/2 mouse to function with any
2.6.x or 2.4.x kernel (same ASUS MB).  The problem is already
so long standing that I have completely given up on it and use
a serial mouse exclusively and no longer bother with ps/2.

(I also hate to report that since I dual boot with MS Windows,
the ps/2 mouse functions properly under the same conditions
with MS Windows 2K.  The hardware cannot be at fault.) 

> As a clarification, I have been having these keyboard problems 
> intermittently, regardless of whether I'm using -mm or mainline kernel.  
> I was NOT having this problem in 2.6.11  I wasn't having the psaux mouse 
> problems in 2.6.11 either  .... I unplugged my psaux mouse from that 
> machine before 2.6.12-mainline was released, so I don't know if those 
> symptoms are still present.

Actually, my keyboard problems began with kernel-2.6.11, but were
quickly resolved when I used the following parameter in my lilo.conf
file:

i8042.nomux

When I use this parameter, or any other i8042 specific parameter,
with kernel-2.6.12, there is no effect.  The keyboard still occasionally
comes up dead.

Thanks for the information on unplugging and re-plugging the keyboard.
I'll give that a try soon.

Frank Peters

(Please CC to frank.peters@comcast.net as I am not a subscriber to this
list.)
