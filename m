Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317649AbSGUG7x>; Sun, 21 Jul 2002 02:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317650AbSGUG7x>; Sun, 21 Jul 2002 02:59:53 -0400
Received: from lenin.nu ([192.31.21.154]:28081 "HELO lenin.nu")
	by vger.kernel.org with SMTP id <S317649AbSGUG7w>;
	Sun, 21 Jul 2002 02:59:52 -0400
Date: Sun, 21 Jul 2002 00:02:47 -0700
From: "Peter C. Norton" <spacey@lenin.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: crash 2.4.19-rc3 on smp machine.
Message-ID: <20020721070247.GH16651@lenin.nu>
References: <000b01c23005$fef760f0$0200a8c0@eero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c23005$fef760f0$0200a8c0@eero>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a freeze on an SMP P2 yesterday under 2.4.19-rc1 (needed it
to fix scsi issues with an aic7xxx).  Seems like there's some kind of
a problem out there.

I didn't get any log info from the crash.  How'd you get that stuff in
syslog?  Are you logging to a remote syslog server?

-Peter

On Sat, Jul 20, 2002 at 06:56:22PM +0300, Eero Volotinen wrote:
> Jul 20 15:02:06 gw kernel: kernel BUG at page_alloc.c:220!
> Jul 20 15:02:06 gw kernel: invalid operand: 0000
> Jul 20 15:02:06 gw kernel: CPU:    1
> Jul 20 15:02:06 gw kernel: EIP:    0010:[<c013147e>]    Not tainted
> Jul 20 15:02:06 gw kernel: EFLAGS: 00010202
> Jul 20 15:02:06 gw kernel: eax: 00000040   ebx: c149d2f8   ecx: 00001000
> edx: 0001ad85
> Jul 20 15:02:06 gw kernel: esi: c02968d4   edi: 0001effd   ebp: 0001effd
> esp: dad8fe3c
> Jul 20 15:02:06 gw kernel: ds: 0018   es: 0018   ss: 0018
> Jul 20 15:02:06 gw kernel: Process run (pid: 30135, stackpage=dad8f000)
> Jul 20 15:02:06 gw kernel: Stack: 00001000 00019d85 00000296 00000000
> c02968d4 c0296a60 000001ff 00000000
> Jul 20 15:02:06 gw kernel:        c149d63c c0131711 c02968d4 c0296a5c
> 000001d2 dad8e000 00000000 00000000
> Jul 20 15:02:06 gw kernel:        00000001 c149d63c c0126602 c0126c1d
> dcdffd40 08074000 00000000 dbae76c0
> Jul 20 15:02:06 gw kernel: Call Trace:    [<c0131711>] [<c0126602>]
> [<c0126c1d>] [<c0126e0d>] [<c01211e6>]
> Jul 20 15:02:06 gw kernel:   [<c0113a6a>] [<c01272ca>] [<c01138b0>]
> [<c0108c0c>]
> Jul 20 15:02:06 gw kernel:
> Jul 20 15:02:06 gw kernel: Code: 0f 0b dc 00 e3 84 25 c0 8b 43 18 a9 80 00
> 00 00 74 08 0f 0b
> Jul 20 15:02:07 gw kernel:  kernel BUG at page_alloc.c:220!
> Jul 20 15:02:07 gw kernel: invalid operand: 0000
> Jul 20 15:02:07 gw kernel: CPU:    1
> Jul 20 15:02:07 gw kernel: EIP:    0010:[<c013147e>]    Not tainted
> Jul 20 15:02:07 gw kernel: EFLAGS: 00010202
> 
> ..
> 
> --
> Eero

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
