Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318408AbSGaRSw>; Wed, 31 Jul 2002 13:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318410AbSGaRSw>; Wed, 31 Jul 2002 13:18:52 -0400
Received: from www.transvirtual.com ([206.14.214.140]:32269 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318408AbSGaRSv>; Wed, 31 Jul 2002 13:18:51 -0400
Date: Wed, 31 Jul 2002 10:22:05 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Nico Schottelius <nico-mutt@schottelius.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
In-Reply-To: <20020731175743.GB1249@schottelius.org>
Message-ID: <Pine.LNX.4.44.0207311020420.13905-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just wanted to report of the following problems:
>
> Compile Problems when selecting the following:
> - Selected PCMCIA-SCSI

Been broken. A new driver is being worked on.

> - Selected Framebuffer -> Aty128fb

> Other bugs:
> - devfs init is still missing -> /dev/vc/0 is the only console.

Ug. That is partially fixed. I did get the other vc/X but only root can
access them. I have to talk to linus about the best solution here.

