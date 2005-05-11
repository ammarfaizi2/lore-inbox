Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVEKRyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVEKRyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVEKRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:54:36 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:15024 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262021AbVEKRxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:53:08 -0400
Subject: Re: ioctl to keyboard device file
From: Marcel Holtmann <marcel@holtmann.org>
To: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0505112301350.31722@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in>
	 <1115831651.23458.74.camel@pegasus>
	 <Pine.LNX.4.60.0505112301350.31722@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Wed, 11 May 2005 19:53:20 +0200
Message-Id: <1115834000.23458.77.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >>       I want to add a new ioctl to keyboard driver device file which will
> >> perform the work of copying user space data  sent to it into kernel
> >> space and send those characters  to handle_scancode function of keyboard
> >> driver.. Now I want to know
> >>
> >> 1) what is the device file corresponding to keyboard (is it
> >> /dev/input/keyboard).
> >> 2) where file operations structure is defined for that.
> >> 3) where the those ioctls handled(not found in keyboard.c).
> >>
> >> Any small help is appreciated.
> >
> > why not using uinput for this job?
> 
>    Thanks for the solution.  I did the above task, by defining a new
> character device driver and sending ioctl to it. and calling
> handle_scancode from it. Now I want
> to do the same task with in the keyboard driver. For that I need to send
> ioctl to keyboard device file.
> For that only I asked the
> above doubts.

what your are trying to do looks wrong to me. Why don't you use uinput.
It is there and it is the correct thing for the job.

Regards

Marcel


