Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKSB6j>; Sat, 18 Nov 2000 20:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbQKSB62>; Sat, 18 Nov 2000 20:58:28 -0500
Received: from slc671.modem.xmission.com ([166.70.7.163]:12554 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129659AbQKSB6K>; Sat, 18 Nov 2000 20:58:10 -0500
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
In-Reply-To: <20001118141524.A15214@nic.fr> <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva> <20001118223455.G23033@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Nov 2000 17:29:30 -0700
In-Reply-To: Werner Almesberger's message of "Sat, 18 Nov 2000 22:34:55 +0100"
Message-ID: <m11yw86byt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <Werner.Almesberger@epfl.ch> writes:

> Rik van Riel wrote:
> > Did you try to load an initrd on a low-memory machine?
> > It shouldn't work and it probably won't ;)
> 
> You must be really low on memory ;-)
> 
> # zcat initrd.gz | wc -c
>  409600
> 
> (ash, pwd, chroot, pivot_root, smount, and still about 82 kB free.)

Hmm.... And that's without trying to be small.
I have one that loads a second kernel over the network using dhcp 
to configure it's interface and tftp to fetch the image and boots
that is only 20kb uncompressed....

Compressed I can fit that and a kernel all in plus a minimal
BIOS all in 512K with some room to spare...

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
