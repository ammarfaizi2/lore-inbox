Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314034AbSDVCne>; Sun, 21 Apr 2002 22:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314035AbSDVCnd>; Sun, 21 Apr 2002 22:43:33 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:12812 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314034AbSDVCnc>;
	Sun, 21 Apr 2002 22:43:32 -0400
Date: Sun, 21 Apr 2002 18:41:44 -0700
From: Greg KH <greg@kroah.com>
To: Kris Karas <ktk@enterprise.bidmc.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre2++ USB EHCI-HCD -> auto-reboot
Message-ID: <20020422014144.GA30434@kroah.com>
In-Reply-To: <200204212348.g3LNmoG10576@enterprise.bidmc.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 24 Mar 2002 23:31:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 07:49:52PM -0400, Kris Karas wrote:
> Hello Greg, et al,
> 
> I need some tips on how to debug (or help others debug) a problem I am seeing 
> with the EHCI-HCD driver introduced in 2.4.19-pre2.

First thing would be to try 2.4.19-pre7.
But this does look like a VIA controller, and I think David just sent me
a patch to help fix some problems with this device, so you might be
better off trying this patch against 2.4.19-pre7:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-ehci-2.4.19-pre7.patch

If that patch doesn't help you out, please let me (and the
linux-usb-devel mailing list) know.

thanks,

greg k-h
