Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268464AbTANAtJ>; Mon, 13 Jan 2003 19:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268465AbTANAtJ>; Mon, 13 Jan 2003 19:49:09 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8711 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268464AbTANAtI>;
	Mon, 13 Jan 2003 19:49:08 -0500
Date: Mon, 13 Jan 2003 16:57:56 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mansfield <patmans@us.ibm.com>, Andries.Brouwer@cwi.nl,
       mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sysfs
Message-ID: <20030114005756.GC10764@kroah.com>
References: <UTC200301111443.h0BEhRZ06262.aeb@smtp.cwi.nl> <20030113162741.A18396@beaverton.ibm.com> <20030113165102.A26346@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113165102.A26346@one-eyed-alien.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 04:51:02PM -0800, Matthew Dharm wrote:
> Really, we don't want to hang the device under USB... it's really an
> emulated SCSI device.  Or, at least I think so.

Yes, and since you're looking like a scsi device, and acting like a scsi
device, and you are showing up in the sysfs tree as a scsi device, let's
at least point your device to the proper place, so that the tree shows
the proper representation for what is happening.

thanks,

greg k-h
