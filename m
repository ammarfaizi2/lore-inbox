Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbRAFRcj>; Sat, 6 Jan 2001 12:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbRAFRc2>; Sat, 6 Jan 2001 12:32:28 -0500
Received: from gear.torque.net ([204.138.244.1]:33292 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130406AbRAFRcP>;
	Sat, 6 Jan 2001 12:32:15 -0500
Message-ID: <3A574F5A.6DB74E7C@torque.net>
Date: Sat, 06 Jan 2001 12:01:14 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: APIC-ERROR-Messages -
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> > as far as I understood my smp-board seem not well designed - so I get APIC 
> > error messages nearly every 1-3 seconds. These mmessages do not help me 
> > because -so I was told - it is not possible to fix the problem.
>
> They are a warning that your box isnt going to be happy long term.; Eventually
> a bad message will get through with a good checksum. There was a panic case in
> the code when messages got reset that is fixed in 2.4.0-preleease
> 
> > Is it possible to eliminate these error messages. My logfiles grow enormously 
> > and are "trashed" with these messages...
> 
> You can certainly comment the printk's out of your own tree

At a frequency of 1 every half hour or so from my BP6
motherboard (more frequent during heavy IO) I found that
message pretty annoying and commented it out.

The 'cat /proc/interrupts' last line "ERR: <n>" gives a
running count if you are interested.

Doug Gilbert


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
