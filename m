Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbRAXTZt>; Wed, 24 Jan 2001 14:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRAXTZj>; Wed, 24 Jan 2001 14:25:39 -0500
Received: from styx.suse.cz ([195.70.145.226]:5360 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129737AbRAXTZe>;
	Wed, 24 Jan 2001 14:25:34 -0500
Date: Wed, 24 Jan 2001 20:25:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Message-ID: <20010124202527.A2405@suse.cz>
In-Reply-To: <20010121104606.A398@suse.cz> <Pine.LNX.4.10.10101241003270.14153-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101241003270.14153-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Jan 24, 2001 at 10:04:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 10:04:50AM -0800, Andre Hedrick wrote:

> > Well, I know this. But I fear hardcoded timings won't really help here,
> > unless everyone out there ran their chipsets at 33 MHz, in which case the
> 
> You have to run the ATA Chipset at 33MHz or it will fail in 99% of all
> cases. 

No. Though I'd advise everyone to stick with 33MHz PCI when they can
because it is safe. But even the VIA specs mention 25, 37.5 and 41.5 PCI
speeds.

> This is not the FSB running at 66/83/100/133.  So hardcode is
> correct.

If you set a MVP3 or MVP4 chipset to 83 MHz FSB, you'll get 41.5 MHz
or 27.6 MHz PCI. And there are chips speced for 75 and 83 MHz FSB's -
Cyrix 6x86MX etc.

No way to get 33 here, if you *don't* want to over/under-clock the CPU. 

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
