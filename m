Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbSKOSYa>; Fri, 15 Nov 2002 13:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266774AbSKOSYa>; Fri, 15 Nov 2002 13:24:30 -0500
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:23567 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S266772AbSKOSY3>; Fri, 15 Nov 2002 13:24:29 -0500
Date: Fri, 15 Nov 2002 19:35:25 +0100
To: alan@cotse.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD IO error
Message-ID: <20021115183525.GA1285@gouv>
References: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
User-Agent: Mutt/1.4i
From: Leopold Gouverneur <lgouv@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:42:07AM -0500, Alan Willis wrote:
> 
>   I've been getting these messages since about 2.5.45.  I can't mount any
> cds at all.  Elvtune (util-linux-2.11r) also fails on /dev/hda which I'm
> running on, and /dev/hdc, my cdrom.
> 
> Any further info needed?
> 
> -alan
> 
> end_request: I/O error, dev hdc, sector 0
> hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> end_request: I/O error, dev hdc, sector 0
 Same here. I have disabled DMA for cdrom(CONFIG_IDEDMA_ONLYDISK=y)
 and things are working again, perhaps with a loss operformance?
 Hope it helps.
 
