Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVCCXLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVCCXLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVCCXKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:10:25 -0500
Received: from 80.178.45.95.adsl.012.net.il ([80.178.45.95]:26550 "EHLO
	linux15") by vger.kernel.org with ESMTP id S262679AbVCCXDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:03:08 -0500
From: Oded Shimon <ods15@ods15.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RivaFB and GeForce FX
Date: Fri, 4 Mar 2005 01:03:05 +0200
User-Agent: KMail/1.7.1
References: <1109890416.6974.12.camel@host-172-19-5-120.sns.york.ac.uk>
In-Reply-To: <1109890416.6974.12.camel@host-172-19-5-120.sns.york.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-8-i"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503040103.05479.ods15@ods15.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 00:53, Alan Jenkins wrote:
> Having a GeForce FX 5200 which I expected to work under rivafb (kernel
> version 2.6.11), I found the attached message on google groups.
>
> I know it is a little later now, but would you think about getting the
> work you've done committed?
>
> I recognise that updating the driver to work with more recent kernels
> would involve a reasonable amount of work.  I don't need the driver
> personally (although it would be nice).  I wouldn't be able to take
> advantage of TV out either, but if you can get the code into the kernel
> then more people are likely to look at it.
>
> If you're not going to do anything, could you send me the latest
> version?  I don't promise to do anything but as a student I should have
> the time to do so.  Actuall skill is another matter :)

Wow, it's been ages.. I eventually stopped caring about this patch because i 
realized with my skills TV out would be utterly impossible, which was very 
important for me.. So for now I am STILL using VesaFB and the binary nvidia X 
driver...

The patch I did prepare were a few strategic copy pastes from the X "nv" 
driver which "works" (without TV out) for Geforce FX... I hardly understand 
at all what I have done (hardware, just ain't my thing :).

You're free to have the patch though.. I'd advise cleaning it up though, there 
is still some debugging stuff in there...
Also, this is actually a common trait for Any rivafb output, the cursor is 
horribly broken.. I had a hack in the patch to fix this, but this probably 
not welcome for the official driver...

- ods15
