Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSHVTrK>; Thu, 22 Aug 2002 15:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSHVTrK>; Thu, 22 Aug 2002 15:47:10 -0400
Received: from host.greatconnect.com ([209.239.40.135]:11791 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S316672AbSHVTrJ>; Thu, 22 Aug 2002 15:47:09 -0400
Subject: Re: 2.4.20-pre2-ac4 IDE is slow
From: Samuel Flory <sflory@rackable.com>
To: rob@twcny.rr.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020822175945.GA743@twcny.rr.com>
References: <20020822175945.GA743@twcny.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Aug 2002 12:50:28 -0700
Message-Id: <1030045828.14545.26.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Can you send the ide section of dmesg?  What are the results of hdparm
-t /dev/hda on both kernels?


On Thu, 2002-08-22 at 10:59, Rob Speer wrote:
> I think I remember someone else bringing up this same issue, in which
> case I'm sorry to have to ask again, but I can't find the message.
> 
> I'm going from 2.4.19 to 2.4.20-pre2-ac4 and the hard drive is noticably
> slower in the new version. (It doesn't use DMA in either version - I
> wish it did in ac4, but that's a separate problem.)
> 
> What I seem to remember from the other message is that there's some
> parameter that can be changed to bring the speed back up. Could someone
> tell me what it is?
> 
> 
> If it helps: output of hdparm /dev/hda
> 
> /dev/hda:
>  multcount    =  0 (off)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 77557/16/63, sectors = 78177792, start = 0
> 
> -- 
> Rob Speer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


