Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282222AbRLVUXx>; Sat, 22 Dec 2001 15:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282271AbRLVUXn>; Sat, 22 Dec 2001 15:23:43 -0500
Received: from pop.gmx.de ([213.165.64.20]:25452 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282222AbRLVUXf>;
	Sat, 22 Dec 2001 15:23:35 -0500
Date: Sat, 22 Dec 2001 21:22:06 +0100
From: Andreas Kinzler <akinzler@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: jdike@karaya.com
Subject: Re: Injecting packets into the kernel
X-Mailer: Andreas Kinzler's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011222202340Z282222-18284+6230@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> However, for the kernel they are now LOCAL packets, which are not
>> masq'ed. To make that work, they need to look "remote" (means:
>> received by a device). Any ideas?
> Use a TUN/TAP device (or ethertap on 2.2).

That is exactly what diald does, but the packets written to such a device have
no effect, they do not seem to make their way through the kernel.

