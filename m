Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRCBOCU>; Fri, 2 Mar 2001 09:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRCBOCK>; Fri, 2 Mar 2001 09:02:10 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:49347 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129165AbRCBOCB>; Fri, 2 Mar 2001 09:02:01 -0500
Message-ID: <3A9FA6C6.520AFAE7@coplanar.net>
Date: Fri, 02 Mar 2001 08:57:26 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: PPP problems
In-Reply-To: <Pine.LNX.4.30.0103020510440.1069-100000@roadrunner.hereintown.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob wrote:

> Hi, I'd like to thank everyone that helped me with the compiler problem.
> I've updated everthing in Documentation/Changes I have a brand spankers
> new gcc, ppp, etc.  The problem I'm running into now is when I try to
> connect to the internet, it says that I don't have a kernel that supports
> PPP.  I've tried compiling it in as modules and as part of the kernel but
> when I try to connect to the isp I keep getting the message that I don't
> have a kernel that supports PPP. I've even contacted my System
> Administrator, Hi Chris ;^).  Any ideas on what I could try next?  A cc
> would be great, as I'm not on the linux-kernel list.

Do you have the right kernel configuratoin?  It sounds like
you need to load the modules (or set modules.conf to
auto-load them with "alias" lines)

On linux 2.4 you need ppp_generic, ppp_async, slhc loaded
with modprobe or insmod.

on 2.4 config options under "network device support"

<M> PPP (point-to-point protocol) support
[ ]   PPP multilink support (EXPERIMENTAL)
<M>   PPP support for async serial ports
<M>   PPP support for sync tty ports
<M>   PPP Deflate compression
<M>   PPP BSD-Compress compression
<M>   PPP over Ethernet (EXPERIMENTAL)

your using a modem?  cable or ADSL?

reply to me privately, as linux-kernel probably isn't
the place to discuss this since it sounds like an install
issue... if we find it's a kernel bug then it would be ok.

if you're using a 2.2 kernel i suggest you try the
one that came with your distribution.

oh yeah what is your distribution?

Cheers,

Jeremy

