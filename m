Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRAJI0e>; Wed, 10 Jan 2001 03:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131266AbRAJI0Y>; Wed, 10 Jan 2001 03:26:24 -0500
Received: from [216.161.55.93] ([216.161.55.93]:5364 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130497AbRAJI0M>;
	Wed, 10 Jan 2001 03:26:12 -0500
Date: Wed, 10 Jan 2001 00:26:39 -0800
From: Greg KH <greg@wirex.com>
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb mouse, iomega zip and 2.2.19-pre7
Message-ID: <20010110002639.B26680@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, f5ibh <f5ibh@db0bm.ampr.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200101092046.VAA27628@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101092046.VAA27628@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Tue, Jan 09, 2001 at 09:46:14PM +0100
X-Operating-System: Linux 2.4.0 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 09:46:14PM +0100, f5ibh wrote:
> Hi,
> 
> usb-mouse
> ---------
> In 2.2.19-pre6 (and previous) we had a CONFIG_INPUT_MOUSEDEV. It has
> disapearead in 2.2.19-7. The only alternative for an usb mouse seems 
> to be CONFIG_USB_MOUSE which is for an USB HIDBP Mouse.
> 
> So there is no mean to get mousedev & input compiled.
> Maybe "Input core support" is missing with the matching ../drivers/input 
> directory.

Crap, I messed up and forgot about this move.  Patch soon to fix this,
thanks for noticing it.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
