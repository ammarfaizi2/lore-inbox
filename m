Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLLR7P>; Tue, 12 Dec 2000 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLLR6y>; Tue, 12 Dec 2000 12:58:54 -0500
Received: from mail2.aracnet.com ([216.99.193.35]:31249 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S129255AbQLLR6s>; Tue, 12 Dec 2000 12:58:48 -0500
Date: Tue, 12 Dec 2000 09:35:34 -0800
From: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] PROBLEM: USB (MS Intellimouse specifically) does not work with SMP Linux 2.2.18.
Message-ID: <20001212093534.M3046@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Operating-System: Linux 2.2.14-5.0 (i686)
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 02:07:59PM -0000, Laramie Leavitt wrote:
> [1.] One line summary of the problem:
> USB (MS Intellimouse specifically) does not work with SMP kernel 2.2.18.
> 
> [2.] Full description of the problem/report:
> When trying to install a Microsoft Intellimouse Explorer (USB)
> to a SMP kernel, I get the following error multiple times:
> 
> usb.c: USB device not accepting new address (error=-110)

What's your BIOS setting for MSR?

And how about the contents of /proc/interrupts?

This is a case of when the usb code isn't getting the hardware interrupt
delivered properly.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
