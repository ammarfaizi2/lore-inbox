Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277396AbRJEOjx>; Fri, 5 Oct 2001 10:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277398AbRJEOjn>; Fri, 5 Oct 2001 10:39:43 -0400
Received: from host-150.subnet-93.med.umich.edu ([141.214.93.150]:11187 "EHLO
	mail-02.med.umich.edu") by vger.kernel.org with ESMTP
	id <S277396AbRJEOj0> convert rfc822-to-8bit; Fri, 5 Oct 2001 10:39:26 -0400
Message-Id: <sbbd8e9c.096@mail-02.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0
Date: Fri, 05 Oct 2001 10:42:16 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <root@mauve.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Odd keyboard related crashes.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>> Ian Stirling <root@mauve.demon.co.uk> 10/05/01 05:01AM >>>
>I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.

>On plugging back in, all worked fine, until 10 seconds later there was a
>crash. (the keyboard worked after being plugged in)
>No oops, just a reboot.
>Thinking this must just have been a wierd coincidence, after the system
>came back up, I tried it again, and again it crashed a few seconds afterwards.

>It doesn't seem to want to do this again though.

When the keyboard is powered up (or plugged in), it goes through a self test, and reports the status back to the PC. Normally, a start up dialogue takes place between the PC and the keyboard at this point.
That's fine when you boot your PC, but if you unplug then re-plug the keyboard, the PC will be sent data it's really not expecting, and the BIOS will be very confused.
If you ever want to switch a keyboard between PCs, make sure you leave power supplied to it at all times.


