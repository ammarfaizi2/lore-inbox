Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbRGXPpA>; Tue, 24 Jul 2001 11:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267580AbRGXPov>; Tue, 24 Jul 2001 11:44:51 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:26192 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S267577AbRGXPom>;
	Tue, 24 Jul 2001 11:44:42 -0400
Message-ID: <3B5D9799.70807@valinux.com>
Date: Tue, 24 Jul 2001 09:43:21 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul G. Allen" <pgallen@randomlogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD-760 MP AGP Support
In-Reply-To: <3B5CDFC1.4D954891@randomlogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Paul G. Allen wrote:

> Hello, I'm new to the list and I have a question (or two, or three, or... ;)
> 
> I just purchased a Tyan K7 Thunder (Dual Athlon motherboard) and I am running dual 1.4GHz Athlons and a GeForce 3 on it. It appears that the current (2.4.7
> kernel) agpgart module does not directly support the AMD-760 MP chipset. I am planning upon modifying agpgart to support it. My question is: Is anyone already
> doing this? I don't want to re-create the wheel, I just want full support on this screaming fast system.
> 

I have a pre production Tyan mb that I tested things on.  It seemed to 
work just fine with agp_try_unsupported=1.  Please test it with 
agp_try_unsupported on an actual production system to make sure, but if 
it works just send me the output of lspci -vvv and I'll put it in the 
kernel.

-Jeff

