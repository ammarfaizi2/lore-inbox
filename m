Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbQKJReg>; Fri, 10 Nov 2000 12:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130316AbQKJRe1>; Fri, 10 Nov 2000 12:34:27 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:8452 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129805AbQKJReM>;
	Fri, 10 Nov 2000 12:34:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: George Anzinger <george@mvista.com>
cc: John Kacur <jkacur@home.com>, linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 compile error undefined reference to `bust_spinlocks' WHAT?! 
In-Reply-To: Your message of "Fri, 10 Nov 2000 09:15:54 -0800."
             <3A0C2D4A.83C75D4B@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Nov 2000 04:34:06 +1100
Message-ID: <7834.973877646@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000 09:15:54 -0800, 
George Anzinger <george@mvista.com> wrote:
>The notion of releasing a spin lock by initializing it seems IMHO, on
>the face of it, way off.

Normally it would be, but these are NMI and panic messages.  The system
is pretty dead at that point, getting the message out is deemed more
important than maintaining the spinlock.  BTW, bust_spinlocks is not my
idea, please direct any queries to Andrew Morton.  I just fixed a link
error.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
