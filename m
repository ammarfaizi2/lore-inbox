Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAHUJN>; Mon, 8 Jan 2001 15:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAHUJE>; Mon, 8 Jan 2001 15:09:04 -0500
Received: from [216.161.55.93] ([216.161.55.93]:18670 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129401AbRAHUIp>;
	Mon, 8 Jan 2001 15:08:45 -0500
Date: Mon, 8 Jan 2001 12:09:55 -0800
From: Greg KH <greg@wirex.com>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: typo in linux-2.2.18/Documentation/usb/usb-serial.txt
Message-ID: <20010108120955.B23439@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Hisaaki Shibata <shibata@luky.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010109022407R.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109022407R.shibata@luky.org>; from shibata@luky.org on Tue, Jan 09, 2001 at 02:24:07AM +0900
X-Operating-System: Linux 2.4.0-prerelease (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:24:07AM +0900, Hisaaki Shibata wrote:
> Hi!
> 
> I tried to use USB-SERIAL converter shown in 
> http://www.century.co.jp/products/usb_serial1a.html
> that uses Prolific chip.
> 
> Prolific USB2SERIAL is not supported yet,
> so I tried to "generic".
> Then I found typo in the document.
> 
> Here is a tiny patch.

Thanks for the patch, but it's already in the queue in Alan Cox's tree.

You might want to copy the maintainer of the driver with any questions
or patches in the future.

As for this specific device, do you have any specs on the converter?
What does the output of /proc/bus/usb/devices look like with the device
plugged in?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
