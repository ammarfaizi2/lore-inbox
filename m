Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318690AbSICM6B>; Tue, 3 Sep 2002 08:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSICM6B>; Tue, 3 Sep 2002 08:58:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52938 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318690AbSICM6A>; Tue, 3 Sep 2002 08:58:00 -0400
Date: Tue, 3 Sep 2002 15:02:28 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Thomas Koller <kt@aon.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops after X-Server shutdown
In-Reply-To: <1031050498.3d7495028d2e6@webmail.jet2web.at>
Message-ID: <Pine.NEB.4.44.0209031454410.696-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Thomas Koller wrote:

> hi,

Hi Thomas,

> shutting down the x-server with dri support on a i830M graficcard lets the
> kernel produce an oops and left the screen black.
>
> Aug 31 18:16:45 mobile kernel:  printing eip:
> Aug 31 18:16:45 mobile kernel: c0124e20
> Aug 31 18:16:45 mobile kernel: Oops: 0000
>...
> KernelPatches:
>
> DRI Modules http://www.xfree86.org/~alanh/linux-drm-4.2.0-
> kernelsource.tar.gz
>
> ACPI-Patches (acpi.sourceforge.net) acpi-20020821-2.4.19
>
> X-Server: Xfree86 4.2.0
>
> Hardware: TravelMate 621LV
>
> Is there a chance to get Xfree 4.2.0 working with DRI on that hardware?
> maybe this is a bug in the kernel.

1. Could you try whether 2.4.20-pre5 [1] fixes this (with 2.4.20-pre5 you
   don't need the external DRI Modules)?
2. If this doesn't help please run the Oops message from 2.4.20-pre5
   through ksymoops as described in Documentation/oops-tracing.txt and
   send the output to linux-kernel.

> best regards
> thomas

TIA
Adrian

[1] ftp://ftp.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.20-pre5.gz

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


