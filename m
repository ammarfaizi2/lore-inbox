Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275595AbTHOAkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275599AbTHOAkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:40:23 -0400
Received: from maja.beep.pl ([195.245.198.10]:36105 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S275595AbTHOAkV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:40:21 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Greg KH <greg@kroah.com>
Subject: Re: finding which pci device works as ide controller for root fs
Date: Fri, 15 Aug 2003 02:38:30 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308141826.30735.arekm@pld-linux.org> <20030815001552.GA4776@kroah.com>
In-Reply-To: <20030815001552.GA4776@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308150238.30618.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 of August 2003 02:15, Greg KH wrote:
> On Thu, Aug 14, 2003 at 06:26:30PM +0200, Arkadiusz Miskiewicz wrote:
> > [arekm@mobarm arekm]$ ls -l /sys/block/hda/device
> > lrwxrwxrwx    1 root     root           46 2003-08-14 00:49
> > /sys/block/hda/device -> ../../devices/pci0000:00/0000:00:11.1/ide0/0.0
> >
> > Is it possible to get PCI ID from sysfs for specified device?
>
> It's right there in the path to the ide device "0000:00:11.1"
How's that related to awk ' { print $2 } ' /proc/bus/pci/devices?

> greg k-h

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm@sse.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

