Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129231AbQKXQLZ>; Fri, 24 Nov 2000 11:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129325AbQKXQLQ>; Fri, 24 Nov 2000 11:11:16 -0500
Received: from columba.EUR.3Com.COM ([161.71.169.13]:26063 "EHLO
        columba.eur.3com.com") by vger.kernel.org with ESMTP
        id <S129231AbQKXQK4>; Fri, 24 Nov 2000 11:10:56 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: I+D <jbertran@cirsa.com>
cc: "'rminnich@lanl.gov'" <rminnich@lanl.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-ID: <802569A1.00542593.00@notesmta.eur.3com.com>
Date: Fri, 24 Nov 2000 15:13:03 +0000
Subject: Re: Booting AMD Elan520 without BIOS
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>    The last message I see is "Calibrating delay loop"
>(I see this thaks to the Jtag debugger for Elan520 because
>I haven't configured the VGA board yet).

I've seen this on a board with a BIOS problem. I think it is caused because the
Kernel is in a loop waiting for a timer interrupt to occur. If the interrupt
never arrives it loops forever.

     Jon




PLANET PROJECT will connect millions of people worldwide through the combined
technology of 3Com and the Internet. Find out more and register now at
http://www.planetproject.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
