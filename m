Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279662AbRJYA2O>; Wed, 24 Oct 2001 20:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279658AbRJYA2A>; Wed, 24 Oct 2001 20:28:00 -0400
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:22152 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S279666AbRJYA1u>; Wed, 24 Oct 2001 20:27:50 -0400
Date: Wed, 24 Oct 2001 20:28:24 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Harald Dunkel <harri@synopsys.COM>
cc: linux-kernel@vger.kernel.org
Subject: Re: Alsa 0.9beta8a with 2.4.{12,13} ?
In-Reply-To: <3BD72F8F.43E21E66@Synopsys.COM>
Message-ID: <Pine.A41.4.21L1.0110242026450.59430-100000@login8.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the tainted modules warnings: this was fixed a week or so ago in
cvs for both 0.5.11 and head.

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Wed, 24 Oct 2001, Harald Dunkel wrote:

> {root@bilbo:harri 937} /etc/init.d/alsasound restart
> Shutting down sound driver: done
> Starting sound driver: snd-card-via686a Warning: loading /lib/modules/2.4.13/misc/snd.o will taint the kernel: no license
> Warning: loading /lib/modules/2.4.13/misc/snd-seq-device.o will taint the kernel: no license
> Warning: loading /lib/modules/2.4.13/misc/snd-rawmidi.o will taint the kernel: no license
> Warning: loading /lib/modules/2.4.13/misc/snd-mpu401-uart.o will taint the kernel: no license
> Warning: loading /lib/modules/2.4.13/misc/snd-timer.o will taint the kernel: no license
> Warning: loading /lib/modules/2.4.13/misc/snd-pcm.o will taint the kernel: no license
> Warning: loading /lib/modules/2.4.13/misc/snd-ac97-codec.o will taint the kernel: no license
> Warning: loading /lib/modules/2.4.13/misc/snd-card-via686a.o will taint the kernel: no license
> done
> /usr/sbin/alsactl: load_state:1026: No soundcards found...

