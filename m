Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRJCNc2>; Wed, 3 Oct 2001 09:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276255AbRJCNcT>; Wed, 3 Oct 2001 09:32:19 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:35338 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S276249AbRJCNcE>;
	Wed, 3 Oct 2001 09:32:04 -0400
Date: Wed, 3 Oct 2001 15:32:29 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnPBIOS additional fixes
Message-ID: <20011003153229.O574@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011003124423.78EAB58B@thanatos.toad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011003124423.78EAB58B@thanatos.toad.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 08:44:23AM -0400, Thomas Hood wrote:

> > # uname -a
> > Linux crusoe.alcove-fr 2.4.10-ac4 #2 Wed Oct 3 11:20:19 CEST 2001 i586 unknown
> > # cd /proc/bus/pnp
> > # ls
> > boot  devices
> 
> Good ...

Ok.

> Also, "lspnp -bv" should work and "lspnp -v" should fail.

It doesn't:

# lspnp -v
00 PNP0c02 bridge controller: ISA

01 PNP0c01 memory controller: RAM

02 PNP0200 system peripheral: DMA controller

03 PNP0000 system peripheral: programmable interrupt controller

04 PNP0100 system peripheral: system timer

05 PNP0b00 system peripheral: real time clock

06 PNP0303 input device: keyboard

07 PNP0c04 reserved: other

08 PNP0800 multimedia controller: audio

09 PNP0a03 bridge controller: PCI

0b PNP0c02 memory controller: RAM

0c PNP0c02 memory controller: RAM

0d PNP0e03 bridge controller: PCMCIA

0e PNP0f13 input device: mouse


Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
