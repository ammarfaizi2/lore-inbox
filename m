Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRBVMnd>; Thu, 22 Feb 2001 07:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbRBVMnX>; Thu, 22 Feb 2001 07:43:23 -0500
Received: from mail.isis.co.za ([196.15.218.226]:11022 "EHLO mail.isis.co.za")
	by vger.kernel.org with ESMTP id <S129306AbRBVMnN>;
	Thu, 22 Feb 2001 07:43:13 -0500
Message-Id: <4.3.2.7.0.20010222142631.00ba3cb0@192.168.0.18>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 22 Feb 2001 14:42:44 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Pat Verner <pat@isis.co.za>
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear
  (Lite-On)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14VtCQ-0003t2-00@the-village.bc.nu>
In-Reply-To: <4.3.2.7.0.20010222095007.00b9e260@192.168.0.18>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rebuilt the kernel using using 2.4.1 + patch-2.4.1-ac20 :

Initial state is good, and now ping works.  However, if I run IPTRAF, then 
the card grinds to a halt after receiving about 2.6 Mbytes on try 1, then 
11 Mbytes on try 2, after which it will neither receive or transmit :-(

After this the card is in a state such that it requires a reboot to be able 
to do anything further.

=Pat

At 10:42 AM 22/02/2001 +0000, Alan Cox wrote:
> > three Netgear NICs and am experiencing considerable trouble with the=20
> > combination:
> >
> > Kernel 2.4.[01]:        ifconfig shows that the card see's traffic on t=
> > he=20
> > network, but does not transmit anything (no response to ping).
>
>Use a current 2.4.*-ac. Jeff and co fixed this we think.
>
>Alan

--
Pat Verner				E-Mail:  pat@isis.co.za
           Isis Information Systems (Pty) Ltd
           PO Box 281, Irene, 0062, South Africa
Phone: +27-12-667-1411	      	Fax: +27-12-667-3800

