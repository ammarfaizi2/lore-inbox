Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWAZKMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWAZKMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWAZKMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:12:43 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:7909 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932277AbWAZKMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:12:42 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 11:11:16 +0100
To: matthias.andree@gmx.de, axboe@suse.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       grundig@teleline.es, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8A044.nailDTH61O3NY@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
In-Reply-To: <43D7C1DF.1070606@gmx.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Jens Axboe wrote:
>
> > In fact it would be a _lot_ easier to just scan sysfs and do an inquiry
> > on potentially useful devices.
>
> Hm. sysfs, procfs, udev, hotplug, netlink (for IPv6) - this all looks rather
> complicated and non-portable. I understand that applications that can just
> open every device and send SCSI INQUIRY might want to do that on Linux, too.

Another problem is that it is hard to find whether a new feature in Linux will 
still be present some time later.

If I would try to immediately add support for every new feature, I would have a 
lot of dead code in my sources and would need to put a lot of effort in this 
kind of coding. It seems that it makes sense to wait untill all major Linux 
distributions made a new feature their default for some time.....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
