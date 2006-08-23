Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWHWIjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWHWIjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWHWIjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:39:11 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:15370 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S964783AbWHWIjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:39:09 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andre Tomt <andre@tomt.net>
Subject: Re: Hardware vs. Software Raid Speed
Date: Wed, 23 Aug 2006 09:39:14 +0100
User-Agent: KMail/1.9.4
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <44EBFB3E.8070905@perkel.com> <44EC02FD.7050207@tomt.net>
In-Reply-To: <44EC02FD.7050207@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608230939.14158.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 August 2006 08:25, Andre Tomt wrote:
> Marc Perkel wrote:
> > Running Linux on an AMD AM2 nVidia chip ser that supports Raid 0
> > striping on the motherboard. Just wondering if hardware raid (SATA2)
> > is going to be faster that software raid and why?
>
> Beeing a consumer type board (AM2), the "raid on the motherboard" is in
> 99.999% of the cases just software raid implemented in their Windows
> drivers, a bootup setup screen plus some BIOS magic to get the OS booting.

MD has so many benefits anyway that it doesn't make sense to use anything but 
the finest hardware RAID.

For starters, with Linux MD, you can RAID partitions on a disk independently, 
even with different RAID types, and you can port your array to another 
machine without any reconfiguration, on completely different hardware. You 
can also RAID two different technologies, for example PATA and SATA, hot-add 
spares, run with a deliberately failed array, build incomplete arrays (nice 
if you're just about to start a RAID5 but don't have enough discs), the list 
goes on..

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
