Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSHUP3R>; Wed, 21 Aug 2002 11:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSHUP3R>; Wed, 21 Aug 2002 11:29:17 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:24068 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318407AbSHUP3R>;
	Wed, 21 Aug 2002 11:29:17 -0400
Date: Wed, 21 Aug 2002 08:27:58 -0700
From: Greg KH <greg@kroah.com>
To: Steve Hill <steve@navaho.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-ohci preventing reboot on Cobalt Raq550
Message-ID: <20020821152758.GC676@kroah.com>
References: <Pine.LNX.4.44.0208211604350.27257-100000@sorbus2.navaho>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208211604350.27257-100000@sorbus2.navaho>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 24 Jul 2002 14:17:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 04:10:50PM +0100, Steve Hill wrote:
> 
> I'm having a problem with the usb-ohci module under the 2.4.18 kernel 
> running on Cobalt Raq 550's - if the module is loaded then the machine 
> doesn't reboot.  "shutdown -r now" shuts everything down as usual, the 
> kernel displays "Restarting system." on the console, but then it just sits 
> there.  If I rmmod the module before shutting down then it does exactly 
> the same, but after the "Restarting system." message it does actually 
> reboot.
> Has anyone come across this before?  I really don't know what to look for 
> in the ohci driver code that would prevent the system from rebooting, so 
> any help would be appreciated.  Thanks.

Does 2.4.19 show the same behavior?

thanks,

greg k-h
