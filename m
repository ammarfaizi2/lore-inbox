Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWBSLEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWBSLEk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 06:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBSLEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 06:04:40 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:4901 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932297AbWBSLEj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 06:04:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cgHoQT86/8DLLdGBhJNqgVSNGdWFmQTjep94Oaq4Kp0kLb0Vl9xYk+g337zCfarabDZrExkC9hDOfu5MgBAEFyteggpsaaMNVo2JMz36i5G1iUmOpIiXVQUNjkDSHtiyHcmDETrexaA1CoI53sAtml5tTa0xvgEquo+nlo/mIMQ=
Message-ID: <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
Date: Sun, 19 Feb 2006 12:04:38 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: No sound from SB live!
Cc: tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060218231419.GA3219@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060218231419.GA3219@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/06, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
> I have SB Live! here. I remember it worked long time ago. Now I can't
> get it to produce any sound :-(.
>
> root@hobit:~# cat /proc/asound/cards
>  0 [Live           ]: EMU10K1 - SBLive! Value [CT4830]
>                       SBLive! Value [CT4830] (rev.7,
> serial:0x80261102) at 0x3000, irq 20
>  1 [Bt878          ]: Bt87x - Brooktree Bt878
>                       Brooktree Bt878 at 0xd0001000, irq 17
>
> root@hobit:~# uname -a
> Linux hobit 2.6.16-rc4 #1 SMP PREEMPT Sat Feb 18 23:53:41 CET 2006
> i686 GNU/Linux
>

I've got an SB Live! card here as well. Not exactely the same as yours
(mine's rev. 10, yours is rev. 7), but mine works just fine with
2.6.16-rc4, so whatever is wrong it does not seem to effect all SB
Live! cards...

root@dragon:~# cat /proc/asound/cards
 0 [Live           ]: EMU10K1 - SB Live [Unknown]
                      SB Live [Unknown] (rev.10, serial:0x80671102) at
0xd880, irq 20

root@dragon:~# lspci -v
<...>
04:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
        Flags: bus master, medium devsel, latency 32, IRQ 20
        I/O ports at d880 [size=32]
        Capabilities: [dc] Power Management version 1

root@dragon:~# uname -a
Linux dragon 2.6.16-rc4 #1 SMP PREEMPT Sat Feb 18 02:13:29 CET 2006
i686 athlon-4 i386 GNU/Linux


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
