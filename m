Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315795AbSENQPL>; Tue, 14 May 2002 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315796AbSENQPK>; Tue, 14 May 2002 12:15:10 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:36357 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315795AbSENQPK>;
	Tue, 14 May 2002 12:15:10 -0400
Date: Tue, 14 May 2002 08:14:10 -0700
From: Greg KH <greg@kroah.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB lockup in 2.4.18-pre8
Message-ID: <20020514151409.GB18117@kroah.com>
In-Reply-To: <20020514180526.4b1691a0.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 16 Apr 2002 13:40:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 06:05:26PM +0200, Stephan von Krawczynski wrote:
> Hello,
> 
> beginning with 2.4.18-pre7 I notice a complete system lockup using a SANDISK
> SDDR-05 compactflash USB adapter.
> I used the device in earlier kernel versions with the "UHCI Alternate Driver",
> but in 2.4.18-pre7 I experienced a complete system lockup when mounting the
> flash card. So I switched over to "UHCI (Intel ..." device, which worked ok in
> 2.4.18-pre7.
> Unfortunately starting with 2.4.18-pre8 I had to find out that now both
> UHCI-drivers produce the lockup. Since I did not find any hints in lkml from
> others I thought it might be worth dropping a note...
> 
> I am willing to try out whatever is necessary.

Can you try compiling the usb-storage driver with the "Debug messages"
option enabled?  Then send the log file and info to the usb-storage
author/maintainer and the linux-usb-devel mailing list?  That's a better
place for questions like this.

thanks,

greg k-h
