Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSFJUTj>; Mon, 10 Jun 2002 16:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSFJUTi>; Mon, 10 Jun 2002 16:19:38 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:38623 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S316080AbSFJURi>; Mon, 10 Jun 2002 16:17:38 -0400
Message-ID: <3D050841.4070306@drugphish.ch>
Date: Mon, 10 Jun 2002 22:12:49 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Bonin <kernel@bonin.ca>
Cc: root@chaos.analogic.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <Pine.LNX.3.95.1020610141042.17451B-100000@chaos.analogic.com> <3D04EDC1.8010402@drugphish.ch> <3D04F704.5090202@bonin.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> A lot of caddies that wrap hd's have started coming out and, as you may 
> know, USB 2.0 supports 480mbps x-fer rate (ideal).  So it's pretty 
> intreguing.

Yeah, I know but ieee1394 with 400Mbps is fast enough for my laptop and 
honestly I doubt that either one, be it USB2.0 or ieee1394, can really 
sustain this high transfer rate for a reasonable amount of time. And for 
most applications it is simply not needed. Maybe if you do TCP/IP over 
those technologies. But YMMV and I accept that. For me it was the 
cheapest alternative (450 bucks) to buying another harddisk for my laptop.

> Does the SCSI layer via sbp2 provide functionality for USB 2.0 (EHCI) 
> disks?

Please read the first 150 lines of [1]. If you want USB2.0 (wrapped) 
devices support you need to check out [2]. It's a 'glue' with the SCSI 
subsystem, but Greg KH can tell you much more about it.

[1] ../linux/drivers/ieee1394/sbp2.c
[2] ../linux/drivers/usb/storage/*, specially transport.c

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

