Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262729AbTCTW07>; Thu, 20 Mar 2003 17:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbTCTW0L>; Thu, 20 Mar 2003 17:26:11 -0500
Received: from port-212-202-173-211.reverse.qdsl-home.de ([212.202.173.211]:53632
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id <S262684AbTCTW0A> convert rfc822-to-8bit; Thu, 20 Mar 2003 17:26:00 -0500
Date: Thu, 20 Mar 2003 23:39:18 +0100 (CET)
Message-Id: <20030320.233918.730551503.rene.rebe@gmx.net>
To: ncunningham@clear.net.nz
Cc: linux-kernel@vger.kernel.org, swsusp@lister.fornax.hu,
       rock-linux@rocklinux.org
Subject: Re: Testers wanted: Software Suspend for 2.4
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <1048023854.2163.16.camel@laptop-linux.cunninghams>
References: <1048023854.2163.16.camel@laptop-linux.cunninghams>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks for your work!

I just manged to suspend and resume a freshly booted 2.4.20 + "your
latest patch" system ;-)

I had to read the kernel source a hour to do so, because I use devfs
and naively used resume=/dev/ide/host0/.... which obiously does not
work.

For now you might add to the docs that devfs users simply have to use
the corresponding old /dev/hdX name. If I have too much time I'll take
a look to make swsuspend devfs aware. But this might not be that soon
:-(

I'll report after more testing.

On: Wed, 19 Mar 2003 09:44:15 +1200,
    Nigel Cunningham <ncunningham@clear.net.nz> wrote:
> Hi all.
> 
> If you're using a 2.4 kernel and haven't tried software suspend, or
> haven't tried it in a while, would you please consider giving it a try?
> The patches can be found on sourceforge.net/projects/swsusp. You'll want
> to download beta19 and then add the patches from the devel section
> beta19-0[1-8]. All feedback is welcome on the swsusp list. You'll find a
> link to it by going to the homepage from there.
> 
> This is the code I'm currently completing a port of to 2.5, so I'll
> shortly (DV) be after testers for the 2.5 version too.
> 
> Regards,
> 
> Nigel

Have fun,
- René

--  
René Rebe - Europe/Germany/Berlin
e-mail:   rene@rocklinux.org, rene.rebe@gmx.net
web:      http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.de/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
