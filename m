Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316572AbSFPUy7>; Sun, 16 Jun 2002 16:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSFPUy6>; Sun, 16 Jun 2002 16:54:58 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:25523 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316572AbSFPUy5> convert rfc822-to-8bit; Sun, 16 Jun 2002 16:54:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: James Bottomley <James.Bottomley@steeleye.com>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map
Date: Sun, 16 Jun 2002 22:54:42 +0200
User-Agent: KMail/1.4.1
Cc: Andries.Brouwer@cwi.nl, garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
References: <200206161725.g5GHP6S23020@localhost.localdomain>
In-Reply-To: <200206161725.g5GHP6S23020@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206162254.42323.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 16. Juni 2002 19:25 schrieb James Bottomley:
> Since we already have a huge long list of different ways to identify
> different devices, I don't think coding any one or even a set of such
> methods into the kernel would satisfy everyone.
>
> What about a different approach:
>
> We already (nearly) have the scsimon patches to do hot plug events on
> SCSI devices incorporated.  Any identification could be done from the
> scsi device hotplug script (i.e. if you see it's USB, get the GID, if
> it's enterprise storage get the WWN, try the filesystem UUID etc).  Then
> all the hotplug script does is plug this device into some type of volume
> idenfication scheme like /dev/volume/<name>.

How would you find out what a device is ?
If the kernel has to supply the information anyway, you could
just as well pass all information to the script or devfs.

	Regards
		Oliver

