Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSHQW4H>; Sat, 17 Aug 2002 18:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318766AbSHQW4H>; Sat, 17 Aug 2002 18:56:07 -0400
Received: from wotug.org ([194.106.52.201]:59706 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S318765AbSHQW4D>;
	Sat, 17 Aug 2002 18:56:03 -0400
Date: Sat, 17 Aug 2002 23:57:43 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?  IDE-TNG driver
In-Reply-To: <Pine.LNX.4.10.10208171057390.23171-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208172353330.3111-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Andre Hedrick wrote:
>
>ide_ioctl(fd, HDIO_SET_IDE_SCSI, bool)

Seems fine to me...

>Where bool does the subdriver switch.
>Just that ioctl's are being blasted and people using are frowned upon.

? so how is cdrecord (or whatever) supposed to do its stuff -- is it ioctl()  
-> fcntl()? If so, I suppose that's ok, but the basic premise still exists,
surely?

>This was a feature Alan Cox poked me for to try and move away from how
>modules are basically an all or nothing grab-all.

I don't think modules are the answer to any of this:
 a) some people want basically module-less kernels
 b) in some environments, you need to be able to select the IO mechanism 
    without the ability to select the module to load.

anyway...

<slightly confused by it all>


Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

