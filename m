Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282129AbRLVThX>; Sat, 22 Dec 2001 14:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282133AbRLVThO>; Sat, 22 Dec 2001 14:37:14 -0500
Received: from mnh-1-02.mv.com ([207.22.10.34]:49926 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S282129AbRLVTg4>;
	Sat, 22 Dec 2001 14:36:56 -0500
Message-Id: <200112222057.PAA02343@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andreas Kinzler <akinzler@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Injecting packets into the kernel 
In-Reply-To: Your message of "Sat, 22 Dec 2001 19:26:21 +0100."
             <20011222182648Z286844-18284+6190@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Dec 2001 15:57:14 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akinzler@gmx.de said:
> However, for the kernel they are now LOCAL packets, which are not
> masq'ed. To make that work, they need to look "remote" (means:
> received by a device). Any ideas?

Use a TUN/TAP device (or ethertap on 2.2).

				Jeff

