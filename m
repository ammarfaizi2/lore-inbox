Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVHKRSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVHKRSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVHKRSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:18:07 -0400
Received: from smtpout.mac.com ([17.250.248.83]:27124 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751132AbVHKRSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:18:06 -0400
In-Reply-To: <Pine.LNX.4.61.0508111256440.15112@chaos.analogic.com>
References: <20050811144457.2598.qmail@science.horizon.com> <Pine.LNX.4.61.0508111058580.14789@chaos.analogic.com> <75F35484-8D34-4B1A-B158-92930EA704D6@mac.com> <Pine.LNX.4.61.0508111256440.15112@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1E06281F-A481-42B1-B90A-1A68C4070913@mac.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CCITT-CRC16 in kernel
Date: Thu, 11 Aug 2005 13:17:51 -0400
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 11, 2005, at 13:08:56, linux-os (Dick Johnson) wrote:
> Okay. Thanks. This means that hardware somehow swapped bits
> before doing a CRC. I wasn't aware that this was even possible
> as it would require additional storage, well I guess anything
> is now possible in a FPGA.
>
> The "Bible" has been:
>      http://www.joegeluso.com/software/articles/ccitt.htm
>
> Note that on the very first page, reference, is made to
> the 0x1021 poly. Then there is source-code that is entirely
> incompatible with anything in the kernel, but is supposed to
> work (it does work on my hardware).
>
> I have spent over a week grabbing everything on the Web that
> could help decipher the CCITT CRC and they all show this
> same kind of code and same kind of organization. Nothing
> I could find on the Web is like the linux kernel ccitt_crc.
> Go figure.
>
> Do you suppose it was bit-swapped to bypass a patent?

It could be that, or it could be some kernel genius figured
out that one method is faster or better or more magical than
the other on most platforms.  Since the code works well, I
would be disinclined to tinker with it. :-D.

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



