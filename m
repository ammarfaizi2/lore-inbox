Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288157AbSACDF2>; Wed, 2 Jan 2002 22:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288156AbSACDFU>; Wed, 2 Jan 2002 22:05:20 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:41998 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288152AbSACDFB>;
	Wed, 2 Jan 2002 22:05:01 -0500
Date: Wed, 2 Jan 2002 19:03:57 -0800
From: Greg KH <greg@kroah.com>
To: Roger Leblanc <r_leblanc@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
Message-ID: <20020103030356.GA5313@kroah.com>
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca> <20020103002827.GA4462@kroah.com> <3C33AF4F.7000703@videotron.ca> <20020103013231.GA4952@kroah.com> <3C33BD88.3010903@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C33BD88.3010903@videotron.ca>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 06 Dec 2001 00:56:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 09:10:16PM -0500, Roger Leblanc wrote:
> umount seg-faults while unmounting /proc/bus/usb! Then modprobe also 
> seg-faults while unloading usb-uhci!!! But the system stays up.
> After that, I cannot make my scanner to work even if I run 
> ".../init.d/usb start".

Can you run that first oops through ksymoops and send it.  Actually do
it for both oopses.

> B.T.W. Did I tell you that I can bring the kernel down just by turning 
> the scanner off and then back again?

Hm, sounds like the scanner driver has some problems :)
You might email the author with this info and see if he has any ideas.

greg k-h
