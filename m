Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135689AbRD3Shb>; Mon, 30 Apr 2001 14:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135532AbRD3ShU>; Mon, 30 Apr 2001 14:37:20 -0400
Received: from adsl-63-206-198-42.dsl.snfc21.pacbell.net ([63.206.198.42]:51658
	"EHLO adsl-63-206-198-42.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S135513AbRD3SgW> convert rfc822-to-8bit; Mon, 30 Apr 2001 14:36:22 -0400
Date: Mon, 30 Apr 2001 11:34:27 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Elmer Joandi <elmer@linking.ee>, Ookhoi <ookhoi@dds.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work
In-Reply-To: <3AED980A.4323AF7D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0104301011380.17715-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Jeff Garzik wrote:

> Elmer Joandi wrote:
> > the whole pcmcia does not work in 2.4.
> 
> Prove it.
> 
> It works for people with correct 2.4 kernel configurations.

   What is a 'correct 2.4 kernel configuration'? Or more importantly how
do I tell if mine is correct?

Here's what I have in my config file:

CONFIG_HOTPLUG=y

CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_I82365=y

CONFIG_NET_ETHERNET=y

CONFIG_NET_RADIO=y
# CONFIG_STRIP is not set
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
# CONFIG_AIRONET4500_PNP is not set
# CONFIG_AIRONET4500_PCI is not set
# CONFIG_AIRONET4500_ISA is not set
# CONFIG_AIRONET4500_I365 is not set
CONFIG_AIRONET4500_PROC=m

CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m

CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_AIRONET4500_CS=m

   Is there any important setting that I might have missed?

   I noticed that I was not loading the module aironet4500_proc. But
loading it does not change anything except that I now have stuff in
/proc/sys/aironet4500. But it doesn't really give me much more
information.


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
   Nouvelle version : les anciens bogues ont été remplacés par de nouveaux.


