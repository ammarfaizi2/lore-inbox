Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVLTDtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVLTDtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 22:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVLTDtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 22:49:19 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:36333 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750775AbVLTDtS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 22:49:18 -0500
Subject: Re: [RFC] Let non-root users eject their ipods?
From: john stultz <johnstul@us.ibm.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051220035122.GA7233@animx.eu.org>
References: <1135047119.8407.24.camel@leatherman>
	 <20051220035122.GA7233@animx.eu.org>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 19:49:18 -0800
Message-Id: <1135050558.8407.36.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 22:51 -0500, Wakko Warner wrote:
> john stultz wrote:
> > All,
> > 	I'm getting a little tired of my roommates not knowing how to safely
> > eject their usb-flash disks from my system and I'd personally like it if
> 
> What exactly is ejecting flash media?
> 
> I have USB hard disks, USB Flash sticks, USB DVD-RAM, and an Ipod.  The only
> one that even needs eject is the DVDRam.  IIRC, ALLOW_MEDIUM_MREMOVAL is for
> CD-Rom (and possibly tape).  If the device is not in use, there's no reason
> it cannot be unplugged then.  (Not in use as in not mounted, and noone's
> accessing the raw device).

Again, I'm not much of a SCSI person, so you might be right here.
However, ejecting scsi devices, like firewire or usb disks, tends to
spin the devices down. This, to my understanding, allows for safe
removal (ipods stop flashing the "do not remove" message). 

On USB flash disks, I'd hope umounting the device would suffice in
flushing out any writes, but it seems quite a bit of writing can go on
when the eject command is issued. It might be I'm just being paranoid,
but I've always ejected flash drives as well just to be sure.

thanks
-john





