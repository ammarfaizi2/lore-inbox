Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVFWOoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVFWOoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVFWOoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:44:18 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:44332 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262550AbVFWOoM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:44:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BiTdhfE5b+0HXNZemErtf5YjbKgACMGNuKQM2vfG3kp5u8AR750CdXDqAeBbWBesvgXYm0hrSVRgwJAHFljCkL4I6t/LfW/hrzQEDut9vuZqqZslzm2m519xXOXN0Sw/b6PNXx4o8Urhwy1tCU7Vj/WaBPLiWC4FlJtiiO+0YRc=
Message-ID: <c775eb9b050623074431056898@mail.gmail.com>
Date: Thu, 23 Jun 2005 10:44:12 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
Reply-To: Bharath Ramesh <krosswindz@gmail.com>
To: "Hodle, Brian" <BHodle@harcroschem.com>
Subject: Re: [2.6.12] System becomes unresponsive with USB errors
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <D9A1161581BD7541BC59D143B4A06294021FAA7C@KCDC1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D9A1161581BD7541BC59D143B4A06294021FAA7C@KCDC1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB legacy support is already disabled in my BIOS. I still get these
errors in my dmesg.

-Bharath

On 6/23/05, Hodle, Brian <BHodle@harcroschem.com> wrote:
> Bharath,
>    I also have an Athlon 64 workstation, and had the same problem. You need
> to disable legacy USB support in your BIOS.
> 
> -Brian
> 
> -----Original Message-----
> From: Bharath Ramesh [mailto:krosswindz@gmail.com]
> Sent: Wednesday, June 22, 2005 7:21 PM
> To: linux-kernel@vger.kernel.org
> Subject: [2.6.12] System becomes unresponsive with USB errors
> 
> 
> I am running the 2.6.12 kernel on my Athlon64 workstation. I am using
> the Microsoft Wireless Optical Desktop keyboard and mice. Every now
> and then my system becomes unresponsive to the input devices. I can
> still login remotely and my dmesg is full of the following message:
> 
> drivers/usb/input/hid-core.c: input irq status -75 received
> 
> I have filed this bug at bugme.osdl.org the bug number is 4724.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4724
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
