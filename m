Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbRFCPFr>; Sun, 3 Jun 2001 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263210AbRFCO5g>; Sun, 3 Jun 2001 10:57:36 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:24569
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S263173AbRFCO5U>; Sun, 3 Jun 2001 10:57:20 -0400
Date: Sun, 3 Jun 2001 10:56:53 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Oleg Drokin <green@linuxhacker.ru>
cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac7
In-Reply-To: <200106030746.f537kSZ12820@linuxhacker.ru>
Message-ID: <Pine.LNX.4.33.0106031053110.1312-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001, Oleg Drokin wrote:

> Hello!
>
> In article <20010603002310.A8817@lightning.swansea.linux.org.uk> you wrote:
>
> AC> 2.4.5-ac7
> AC> o       Make USB require PCI                            (me)
> Huh?!
> How about people from StrongArm sa11x0 port, who have USB host controller (in
> sa1111 companion chip) but do not have PCI?

If it ever gets to a stability point where it's worth including in Alan's
tree, then the dependency could easily be modified to be "USB requires PCI
or SA1111".  In the mean time I keep that hairball in my tree.


Nicolas

