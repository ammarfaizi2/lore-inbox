Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265405AbRGEXCl>; Thu, 5 Jul 2001 19:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265461AbRGEXCc>; Thu, 5 Jul 2001 19:02:32 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:57873 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265405AbRGEXCW>;
	Thu, 5 Jul 2001 19:02:22 -0400
Date: Thu, 5 Jul 2001 16:00:33 -0700
From: Greg KH <greg@kroah.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about include/linux/macros.h ...
Message-ID: <20010705160033.C6136@kroah.com>
In-Reply-To: <20010705151725.A6021@kroah.com> <XFMail.20010705153503.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010705153503.davidel@xmailserver.org>; from davidel@xmailserver.org on Thu, Jul 05, 2001 at 03:35:03PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 03:35:03PM -0700, Davide Libenzi wrote:
> 
> Ok, let's continue like this :

I know, look at the ones that I am personally responsible for:

./drivers/usb/serial/usbserial.c:#define MAX(a,b)    (((a)>(b))?(a):(b))
./drivers/usb/serial/io_edgeport.h:  #define MAX(a,b)        (((a)>(b))?(a):(b))

I'm not disagreeing about the current mess, just trying to explain why
this mess is there.

greg k-h
