Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbQKUWHw>; Tue, 21 Nov 2000 17:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbQKUWHm>; Tue, 21 Nov 2000 17:07:42 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:49115 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S130607AbQKUWH3>; Tue, 21 Nov 2000 17:07:29 -0500
From: David Lang <david.lang@digitalinsight.com>
To: David Riley <oscar@the-rileys.net>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 21 Nov 2000 14:21:31 -0800 (PST)
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <3A1AEA47.ECF2D50A@the-rileys.net>
Message-ID: <Pine.LNX.4.21.0011211419250.2031-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the problem is that unless you tecompile the kernel to add timing delays,
you cannot change the timing like this (if you put the tests in all your
fast paths to add delays you have just destroyed your performance in the
case where the hardware is good)

also you don't know the hardware is really working properly under windows,
how do you know if the blue screen was caused by a windows bug or a
hardware error.

David Lang

 On Tue, 21 Nov 2000, David Riley wrote:

> Date: Tue, 21 Nov 2000 16:34:08 -0500
> From: David Riley <oscar@the-rileys.net>
> To: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
> Subject: Re: Defective Red Hat Distribution poorly represents Linux
> 
> David Lang wrote:
> > 
> > David, usually when it turns out that Linux finds hardware problems the
> > underlying cause is that linux makes more effective use of the component,
> > and as such something that was marginal under windows fails under linux as
> > the correct timing is used.
> 
> This is true.  What I suppose would be the solution is that if faulty
> hardware is found, a reduction in performance should be made.  This is
> already the case for things like broken PCI BIOS where one can either
> set the initialization to work a different way or try to make the
> machine autodetect it.  I certainly approve of more effective use of any
> given component, but sometimes I think it's better to offer the user a
> choice in the case of faulty hardware.
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
