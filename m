Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKMS1k>; Mon, 13 Nov 2000 13:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQKMS1a>; Mon, 13 Nov 2000 13:27:30 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:54793 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S129044AbQKMS1P>;
	Mon, 13 Nov 2000 13:27:15 -0500
Date: Mon, 13 Nov 2000 20:27:07 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: "Willis L. Sarka" <wlsarka@the-republic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Hard lockup using emu10k1-based sound card
In-Reply-To: <Pine.LNX.4.30.0011131751160.21258-100000@matrix.the-republic.org>
Message-ID: <Pine.LNX.4.21.0011132009020.6877-100000@ccs.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, Willis L. Sarka wrote:
> I get a hard lockup when trying to play a mp3 with XMMS;
> Sound Blaster Live card.  The first second loops, and I lose all
> connectivity to the machine; I can't ping it, can't to a an Alt-Sysq,
> nothing.

Just for reference, I've been use the ALSA drivers for most of the
2.4.0-testX kernels without any problems (provided you use the driver
version that matches the kernel version). Even under high memory
preasure, swapping, NFS traffic, etc. the worst that happens is sporadic
skipping. XMMS and mpg123 in use. I've tried the kernel emu10k1 a few
times but also got similar lockup's. I haven't tried the kernel emu10k1
since the NMI watchdog was added. This should show something? ... but 
I guess you can't see anything because you're in X. I wonder if you'd see
anything if you were using mpg123 and working on the console?

My system:
  RedHat 7.0
  kernel 2.4.0-test11pre3 SMP (soundcore as modules)
  ALSA drivers 0.5.9d
  Gigabyte 440BX SMP (Dual Pentium II 450), 256MB, 
    Intel Ethernet Pro 100, Adaptec AIC-7895 Ultra SCSI

-- 
Hans Grobler <grobh@sun.ac.za>
Department Electronic & Electrical Engineering
University of Stellenbosch, South Africa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
