Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310137AbSCKOuV>; Mon, 11 Mar 2002 09:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310138AbSCKOuM>; Mon, 11 Mar 2002 09:50:12 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:43530 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S310137AbSCKOt5>;
	Mon, 11 Mar 2002 09:49:57 -0500
Mailbox-Line: From tmh@nothing-on.tv  Mon Mar 11 14:49:54 2002
Message-ID: <3C8CC3C5.9040106@nothing-on.tv>
Date: Mon, 11 Mar 2002 14:48:37 +0000
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dog slow IDE
In-Reply-To: <3C8CB3EB.8070704@nothing-on.tv> <20020311152942.A25466@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Hi!
> 
> What does haparm /dev/hda (without the -i) say? Is it using DMA at all?
> It may be set up for UDMA4 or UDMA5 but still run PIO only ... btw what
> chipset is this?
> 
Judging by the pci ids database it's either an AMD Unknown or AMD Opus 
chipset.

hdparm says DMA is enabled (it's enabled by a script a bootup AFAIK).

Installing smartd seems to have helped a lot - it's jumped to 28MB/32MB 
which is a hell of a lot closer to what I was expecting (not sure if 
ATA133 should give 133MB a second or whether that's just a theoretical 
limit).

Not sure why enabling smart would help that much (I'm still working my 
way around the BIOS settings and the way to enable it was far from 
obvious - you have to do a manual config of the hard drive first).

Tony

-- 
"Wipe Info uses hexadecimal values to wipe files. This provides more 
security than wiping with decimal values." -- Norton SystemWorks 2002 Manual

tmh@nothing-on.tv 
http://www.nothing-on.tv

