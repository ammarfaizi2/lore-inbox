Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275951AbSIUWtP>; Sat, 21 Sep 2002 18:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275952AbSIUWtP>; Sat, 21 Sep 2002 18:49:15 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:24591 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275951AbSIUWtO>;
	Sat, 21 Sep 2002 18:49:14 -0400
Date: Sat, 21 Sep 2002 15:53:46 -0700
From: Greg KH <greg@kroah.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
Message-ID: <20020921225346.GA29052@kroah.com>
References: <E17sr4a-0007j8-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17sr4a-0007j8-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 10:41:52PM +0200, Marek Michalkiewicz wrote:
> Hi,
> 
> while getting my Sagatek DCS-CF (aka Datafab KECF-USB) USB/CompactFlash
> adapter to work, I got an Oops after adding US_FL_MODE_XLATE to the
> drivers/usb/storage/unusual_devs.h entry.  Fortunately, my device does
> not require that flag (it just avoids a harmless "test WP failed"
> message, but the Oops a while later is worse ;), but I hope you find
> the bug report useful (I can also see the same problem under 2.4.19).

Could you try the patch at:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103255250215947&w=2
for 2.4.20-pre7 and see if it fixes your problem?

thanks,

greg k-h
