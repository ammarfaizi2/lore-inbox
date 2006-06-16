Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWFPOTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWFPOTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWFPOTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:19:17 -0400
Received: from [204.141.84.57] ([204.141.84.57]:61317 "EHLO kirby.webscope.com")
	by vger.kernel.org with ESMTP id S1751406AbWFPOTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:19:17 -0400
Message-ID: <4492BDCC.60207@linuxtv.org>
Date: Fri, 16 Jun 2006 10:18:52 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Salvatore Sanfilippo <antirez@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: v4l device in userspace
References: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
In-Reply-To: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salvatore Sanfilippo wrote:
> Hello, I'm trying to implement a v4l device driver
> for symbian based smart phones. In theory
> it is very simple:
>
> I've a little program running in the phone, capturing
> images from the camera and sending it to the
> linux box via bluetooth.
>
> In the linux box side, I've a deamon capturing this
> images (via a bluetooth SP channel), and....
> I've to pass the images to a fake v4l device
> driver that actually gets the images form userspace.
>
> Basically I've to pass by the kernel just for
> the interface, and not to do real kernel-side work
> (like to access to the some kind of hardware).
>
> So I've some questions ( thanks in advance
> for any reply).
>
> 1) What's the best way to pass relatively
> high-band data between the v4l fake driver
> and userspace? A char device will do the
> work? ioctl?
>
> 2) What about some way to handle ioctl
> directly from userspace? Given this support
> I may implement the whole code in userspace.
> And I guess there are a lot of other real world
> problems that can be handled in userspace
> given the ability to handle ioctl from there.
>
> If you think 2) is reasonable I may actually
> implement some simple form of generic
> char driver that just allows userspace
> programs to handle read/write/ioctl
> opreations, and then use this to fix
> my real issue.
>
> Thank you very much for the help,
> and sorry if there is something conceptually
> wrong in my questions.
>
> Regards,
> Salvatore
>
> P.S. please take me in CC as I'm not subscribed
> to the linux kernel mailing list.
>
I recommend resubmitting this question to a mailing list that actually 
focuses on this topic:

video4linux-list@redhat.com

However, I highly recommend that you subscribe before you post, as the 
redhat server adds a REPLY-TO header to the video4linux list emails, and 
has been known to drop cc's:

http://www.redhat.com/mailman/listinfo/video4linux-list

See you there!

-Michael Krufky

-- 
Michael Krufky


