Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbRG0HoL>; Fri, 27 Jul 2001 03:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267797AbRG0HoB>; Fri, 27 Jul 2001 03:44:01 -0400
Received: from vpop6-114.pacificnet.net ([209.204.41.114]:260 "HELO pobox.com")
	by vger.kernel.org with SMTP id <S267782AbRG0Hnm>;
	Fri, 27 Jul 2001 03:43:42 -0400
Subject: Re: 2.4.7 + VIA Pro266 + 2xUltraTx2 lockups
To: rjh@groucho.maths.monash.edu.au (Robin Humble)
Date: Fri, 27 Jul 2001 00:44:03 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200107270526.FAA07475@groucho.maths.monash.edu.au> from "Robin Humble" at Jul 27, 2001 03:26:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010727074403.127C61D3A9B@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Are there any known issues with kernel 2.4.7 and VIA pro266 chipsets?

I'm having lockups too, mainly during access to disks on the onboard AMI
IDE RAID, but I've had other lockups too. I'm having the lockups under
both 2.4.7 and 2.2.19/20pre7. This is on an Iwill DVD266-R, dual
1GHz PIII. I'm not getting these lockups under Win2K.

This is a stab in the dark, but does putting "noapic" on the boot
command line help? (I haven't tested this enough to see if it really
works.)

-Barry K. Nathan <barryn@pobox.com>
