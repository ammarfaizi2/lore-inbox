Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbRC0UtU>; Tue, 27 Mar 2001 15:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRC0UtK>; Tue, 27 Mar 2001 15:49:10 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:39685 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131579AbRC0Usw>; Tue, 27 Mar 2001 15:48:52 -0500
Message-ID: <3AC0FCB5.1F7AC0EF@t-online.de>
Date: Tue, 27 Mar 2001 22:48:53 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@linux-fbdev.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problems in 2.4.2 -> lost byte
In-Reply-To: <Pine.LNX.4.31.0103271226140.847-100000@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> >This is easily explained: some byte of the mouse protocol was lost.
> >(Some mouse protocols are even designed to allow
> >easy resync/recovery by fixed bit patterns!)
> >
> >Write an intelligent mouse driver for XFree86 to compensate for
> >lost bytes.
> 
> Or write a kernel input device driver. In fact I probable have a mouse
> driver for you. 

Where can I get your driver?


>        What kind of mouse do you have? Then set your X config to
> have the following:
> 
> Section "Pointer"
>             Protocol    "ImPS/2"
>             Device      "/dev/input/mice"

What is better in using /dev/input/mice than /dev/psaux
on this problem exactly?
