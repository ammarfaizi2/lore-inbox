Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312675AbSDBNnw>; Tue, 2 Apr 2002 08:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSDBNnb>; Tue, 2 Apr 2002 08:43:31 -0500
Received: from port-212-202-171-234.reverse.qdsl-home.de ([212.202.171.234]:51974
	"EHLO drocklinux.dnydns.org") by vger.kernel.org with ESMTP
	id <S312675AbSDBNn2> convert rfc822-to-8bit; Tue, 2 Apr 2002 08:43:28 -0500
Date: Tue, 02 Apr 2002 15:42:21 +0200 (CEST)
Message-Id: <20020402.154221.1025205924.rene.rebe@gmx.net>
To: andihartmann@freenet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] Problems with sis900.c [solution?]
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <3C9D999F.60106@athlon.maya.org>
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I only want to note that there is really a problem with
autonegotiation with the sis900.c driver. We have a sis630 based
Laptop and SiS730 based Workstation using the integrated NIC. They
only autonegotiate once after power-on. When the cable is unplugged
and replugged into a hup/switch/whatever the driver doesn't work
anymore and generates this:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000004 00000000
eth0: Media Link On 100mbps full-duplex
eth0: Media Link Off

error messages. Although I do not know if the posted patch is the
right fix.

On: Sun, 24 Mar 2002 10:17:19 +0100,
    andreas <andihartmann@freenet.de> wrote:
> Hello all,
> 
> This night, I tested kernel 2.4.18 on my server. All seems to be good.
> This morning, after rebooting the server and the connected client, I
> couldn't launch the server no more :-(, because of connection problems.
> Pinging the server shows a lot of missing packets or they take too much
> time - but other packets are transmitted well.
> A connection with ssh isn't possible (client doesn't connect).
> 
> The machines are connected with a crosslink-cable.
> I'm using kernel 2.4.18 on the client and on the server.

[... some more examples ...]

> Regards,
> Andreas Hartmann

k33p h4ck1n6
  René

--  
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.

