Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSEUSGM>; Tue, 21 May 2002 14:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSEUSGL>; Tue, 21 May 2002 14:06:11 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:55813 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315338AbSEUSGL>;
	Tue, 21 May 2002 14:06:11 -0400
Date: Tue, 21 May 2002 11:05:15 -0700
From: Greg KH <greg@kroah.com>
To: "Svein E. Seldal" <Svein.Seldal@edcom.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Custom kernel version and depmod
Message-ID: <20020521180515.GF1295@kroah.com>
In-Reply-To: <KKEHJJLHENOALGODMOGLCECHCBAA.Svein.Seldal@edcom.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 23 Apr 2002 15:02:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 04:23:54PM +0200, Svein E. Seldal wrote:
> 
> Hi,
> 
> I have written a USB device driver for the Linux kernel. For convenience I
> am going to distribute it binary (rpm) in addition to the source. For
> flexibility I intended to distribute the module without enabling the kernel
> module version. However, depmod complains about unresolved symbols if I do
> so (insmod/modprobe works of course). Is there a method of avoiding these
> complaints by depmod or must I compile the driver with the kernel module
> enabled (i.e. depmod is made this way).

A bit off-topic, but any reason why you can not just submit your driver
for inclusion in the main kernel tree?  The USB developers are usually
quite easy to convince to take new drivers :)

And what kind of USB device is your driver for?

thanks,

greg k-h
