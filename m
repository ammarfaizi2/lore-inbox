Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293443AbSBZFeG>; Tue, 26 Feb 2002 00:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293521AbSBZFd4>; Tue, 26 Feb 2002 00:33:56 -0500
Received: from perth.fpcc.net ([207.174.142.141]:26150 "EHLO perth.fpcc.net")
	by vger.kernel.org with ESMTP id <S293443AbSBZFdk>;
	Tue, 26 Feb 2002 00:33:40 -0500
Message-Id: <200202260533.WAA30955@perth.fpcc.net>
Content-Type: text/plain; charset=US-ASCII
From: Peter Hutnick <peter@fpcc.net>
To: John Jasen <jjasen1@umbc.edu>
Subject: Re: wvlan_cs in limbo?
Date: Mon, 25 Feb 2002 22:31:29 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.31L.02.0202252302120.5307822-100000@irix2.gl.umbc.edu>
In-Reply-To: <Pine.SGI.4.31L.02.0202252302120.5307822-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 February 2002 09:03 pm, John Jasen wrote:
> On Mon, 25 Feb 2002, Peter Hutnick wrote:
> > I can't figure out which end is up with wvlan_cs.  Not in the kernel yet
> > . . . but pcmcia-cs package is not for use with 2.4.
> >
> > Could someone give me a hint?
>
> I don't understand why you think that pcmcia-cs is not for use in 2.4. I
> use it on my laptop, which was just recently moved to 2.4.17.

Because linux/Documentation/wavelan.txt says:

   "wvlan_cs" driver (Wavelan IEEE, GPL)
   -----------------
           o Config :      Not yet in kernel
           o Location :    Pcmcia package 3.1.10+
           o on-line doc : http://www.fasta.fh-dortmund.de/users/andy/wvlan/

and that page (@fasta.fh-dortmund.de) says:

   Download:Kernel 2.0.x / 2.1.x / 2.2.x:
    WaveLAN/IEEE Linux driver v1.0.4 (included in pcmcia-cs-3.1.15): 
   pcmcia-cs-3.1.15.tar.gz
    Linux wireless tools v19 (kernel 2.2.13 and earlier):
   wireless_tools.19.tar.gz
    Linux wireless tools v20 (kernel 2.2.14 and later):
   wireless_tools.20.tar.gz
 
   Kernel 2.3.x
    Note that kernel 2.3.x support is currently experimental.
    WaveLAN/IEEE Linux driver v1.0.4 (patch for kernel 2.3.50):
   linux-2.3.50-wvlan.patch.gz
    PCMCIA subsystem v3.1.15: pcmcia-cs-3.1.15.tar.gz
    Linux wireless tools v20: wireless_tools.20.tar.gz
 
and

   Since the linux kernel 2.4.x contains its own WaveLAN/IEEE 802.11 driver,
   this standalone driver is depreciated. Try David Hinds pcmcia package
   and/or the linux kernel driver (orinoco_cs).

   and orinoco_cs from 2.4.17 doesn't work, but wvlan_cs that came with my RH 
   kernel does.

but, I checked out the actual pcmcia-cs page, and it looks like I have to 
abandon my working PCMCIA stuff, is that right?

I'm open to suggestions.  Off list, if you don't mind, being as how I'm off 
topic now.

-Peter
