Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313348AbSDESFw>; Fri, 5 Apr 2002 13:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313350AbSDESFd>; Fri, 5 Apr 2002 13:05:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14074
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313348AbSDESFX>; Fri, 5 Apr 2002 13:05:23 -0500
Date: Fri, 5 Apr 2002 10:07:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide timer trbl ...
Message-ID: <20020405180716.GL961@matchmail.com>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020404195046.GA29089@matchmail.com> <Pine.LNX.4.10.10204042125040.10148-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 09:26:37PM -0800, Andre Hedrick wrote:
> 
> Are you using "taskfile io" if so stop for now until I can give Alan a
> patch update.  If you are not using "taskfile io" it means there is a new
> problem.
> 

Yes I am.

I'm running the same kernel binary on another machine without any trouble.
So it's probably PIO mode that is triggering the problem.  (As mentioned in
the 2.5 ide fla^W threads).

So, for now I'll just use the 19pre4-ac4 kernel instead on this machine
(drives don't support dma according to WIP list, and didn't work in dma mode
on nt4 either)

Mike

lspci for machine without trouble:
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 02)
00:0d.0 Ethernet controller: Intel Corp.: Unknown device 2459 (rev 08)
01:00.0 Display controller: Texas Instruments TVP4020 [Permedia 2] (rev 01)
