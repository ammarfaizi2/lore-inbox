Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbREZXDQ>; Sat, 26 May 2001 19:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbREZXBa>; Sat, 26 May 2001 19:01:30 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262649AbREZXAd>;
	Sat, 26 May 2001 19:00:33 -0400
Message-ID: <3B0F8042.90DD5C5D@pocketpenguins.com>
Date: Sat, 26 May 2001 20:06:58 +1000
From: Greg Banks <gbanks@pocketpenguins.com>
Organization: Pocket Penguins Inc
X-Mailer: Mozilla 4.07 [en] (X11; I; Linux 2.2.1 i586)
MIME-Version: 1.0
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
CC: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <20010525012200.A5259@thyrsus.com> <3B0F3268.A671BC7A@pocketpenguins.com> <002401c0e5aa$0049a000$47a6b3d0@Toshiba>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> 
> > Use LinuxSH standard BIOS
> > CONFIG_SH_STANDARD_BIOS
> >   Say Y here if your target has the gdb-sh-stub package from
> >   www.m17n.org (or any conforming standard LinuxSH BIOS) in FLASH
> >   or EPROM.  The kernel will use standard BIOS calls during boot
> >   for various housekeeping tasks.  Note this does not work with
> >   WindowsCE machines.  If unsure, say N.
> >
> 
> "WindowsCE" word looks very abrupt in Linux's Configure.help, Please use
> some better word inspite of it like HandHeld Devices or PDAs.

  The class of machines for which this option does not apply is
"machines with an existing operating system in mask rom and no
flash", which AFAICT is equivalent to "WindowsCE machines
".  The
class "handheld devices" is too broad as it includes machines
like the Rockwell DMIDA which is handheld but has flash.  So
this seems to me to be a reasonably good choice of words.

  Having said that, I agree that the help text entries for the SH
port are in general of less than stellar quality, for various 
(mostly good) reasons.  I'm hoping ESR will give us some editorial
feedback which will provide a good excuse to fix them.

Greg.
-- 
These are my opinions not PPIs.
