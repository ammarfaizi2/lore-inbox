Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271298AbTHCWIL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271308AbTHCWIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 18:08:11 -0400
Received: from [66.155.158.133] ([66.155.158.133]:51072 "EHLO ns")
	by vger.kernel.org with ESMTP id S271298AbTHCWII convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 18:08:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: John Bradford <john@grabjohn.com>, bbeutner@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: issues with any ac sources, and 2.6
Date: Sun, 3 Aug 2003 19:06:45 -0400
User-Agent: KMail/1.4.3
References: <200308032056.h73KuEem000277@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200308032056.h73KuEem000277@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308031906.46052.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got one of those in my office running 2.4.21-ac.  It runs well. Do you want 
to try my kernel?  Those boards are real sensitive to ESD and constantly 
loose their BIOS values if you swap a board out or pull a cable. I had one 
that refused to boot on me today and I just pulled and reseated the PCI cards 
and it came back to life.

On Sunday 03 August 2003 04:56 pm, John Bradford wrote:
> > i run a tyan tiger s2462 board with dual athlons, with the gentoo
> > flavor on it, recently i tried to run the ac sourcess kernel on this
> > machine, however upon boot the machine would just freeze up in the
> > middle of kernel boot, either dying while attaching ide's to devices
> > or while detecting the ide chipset, the odd part to this is that
> > using generic linux sources the machine boots just fine the other
> > issue seems to be that using the 2.6-beta versions it panic.
> > it does so by telling me that i have corrupt cpu context and then
> > panics, there are no hints or warning as to what it could be any
> > help would be greatly appreciated
>
> For the AC kernels, try backing out just the IDE patches, and see if
> that allows you to boot.
>
> For 2.6, does the machine finish booting, and then panic, or does it
> panic during the boot?  Did you try any of the 2.5 kernels, or did you
> start with 2.6?  If it panics during boot, does it always panic at the
> same place, and if so where?  Posting the boot time output of dmesg,
> and lspci -vvv would be helpful here.
>
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
