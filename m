Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282981AbRLWO2s>; Sun, 23 Dec 2001 09:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRLWO2i>; Sun, 23 Dec 2001 09:28:38 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:8719 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S283938AbRLWO2X>;
	Sun, 23 Dec 2001 09:28:23 -0500
Date: Sun, 23 Dec 2001 15:28:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sipos Ferenc <sferi@dumballah.tvnet.hu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: via ide issue
Message-ID: <20011223152818.A13000@suse.cz>
In-Reply-To: <1009109068.1438.11.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1009109068.1438.11.camel@zeus.city.tvnet.hu>; from sferi@dumballah.tvnet.hu on Sun, Dec 23, 2001 at 01:04:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 01:04:28PM +0100, Sipos Ferenc wrote:
> Hi!
> 
> I have an ASUS K7M mobo with via 686a chipset, my bios recognizes my hd
> as udma4 capable, I have a dvd drive on the same ide channel as slave,
> which is udma2 capable. Even if I give the kernel parameter: ide1=ata66,
> (both drives are on the secondary channel) the hd switches back to udma3
> mode, and by the dvd, dma is disabled, I have to switch it with hdparm.
> Earlier kernels 2.4.4 and so, allowed me to switch to udma4 mode without
> file corruption. So, I think, something must be done to correct the
> driver problem. Any help appreciated. My current kernel is 2.4.17-rc2,
> but the via driver has changed earlier, I think.

There were no changes in the VIA driver since 2.4.4 which could cause
this, as far as I know. Now if you could provide some more information
(/proc/ide/via, hdparm -i /dev/hd* ...), perhaps we could find out
what's happening.

-- 
Vojtech Pavlik
SuSE Labs
