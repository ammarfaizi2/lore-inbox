Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTKBV2w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 16:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTKBV2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 16:28:52 -0500
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:5344 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S261817AbTKBV2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 16:28:50 -0500
From: Rob <rpc@cafe4111.org>
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: turning off harddisk and listen music from ramdisk under Linux
Date: Sun, 2 Nov 2003 04:29:13 -0500
User-Agent: KMail/1.5.4
References: <3FA57F86.7CEAC8A8@tiscali.de>
In-Reply-To: <3FA57F86.7CEAC8A8@tiscali.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311020429.13532.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for overall project assistance:

    http://www.linuxquestions.org

for turning off hard drive after a song load:

    hdparm -Y /dev/hdX

for a ramdisk:

    mount -t tmpfs none /mnt/ramdisk

or add this to /etc/fstab:

    none /tmp/jack tmpfs defaults 0 0

On Sunday 02 November 2003 05:04 pm, Martin Wierich wrote:
> Hi guys,
>
> I want to use a PC to listen mp3-music. Therefore I have to buy a new
> harddisk.
> I use Linux and I want to turn off all harddisks while listening,
> because
> they are so noisy. My plan is to let some homegrown software regularly
> copy the music data
> from a harddisk to a ramdisk and to turn off the harddisk then. Then I
> would
> listen from the ramdisk.
>
> My questions:
>  - is this possible?
>  - how do I turn off a harddisk from software under Linux?
>  - do I have to buy a special harddisk?
>  - how does linux react on turning off all harddisks? Can
>    I cut away any superfluous stuff like CRON and let Linux
>    also run on a ramdisk? Or do I need some special embedded
>    Linux distribution?
>  - or is there a readymade solution?
>
> There are the following circumstances:
>  - for religious reasons I only use _old_ hardware (64MB, 100Mhz)
>  - I am planning to have a boot partition just for the sole
>    purpose of listening to music
>  - I want to keep this boot partition small: no X windows stuff,
>    no network and so on. The system should start up very
>    fast.
>  - I have a SuSE Linux distribution on CD Rom. I only have a 56K
>    modem. I don't want to download software for hours.
>
> Any help would be appreciated.
>
> cheers
>
>   Martin

