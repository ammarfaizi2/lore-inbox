Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129320AbRBAFNE>; Thu, 1 Feb 2001 00:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129685AbRBAFMy>; Thu, 1 Feb 2001 00:12:54 -0500
Received: from [192.190.204.1] ([192.190.204.1]:29944 "EHLO mule.dso.org.sg")
	by vger.kernel.org with ESMTP id <S129320AbRBAFMl>;
	Thu, 1 Feb 2001 00:12:41 -0500
Date: Thu, 1 Feb 2001 13:11:30 +0800
From: Richard Shih-Ping Chan <cshihpin@dso.org.sg>
To: linux-kernel@vger.kernel.org
Subject: CVS ld breaks in arch/i386/boot/Makefile
Message-ID: <20010201131130.A943@cshihpin.isl.dso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a warning to those of you who
(are so foolhardy as to:-)) use CVS binutils to build
the linux kernel. The current CVS ld requires that
the option
 ld ... -oformat binary ...
now be written as
 ld ... --oformat binary ...
Note the two dashes.
This breakage occurs in arch/i386/boot/Makefile

[From the maintainers: this is necessary to avoid confusion
with other options like  -o format]




-- 

Chan Shih-Ping (Richard) <cshihpin@dso.org.sg>
DSO National Laboratories
20 Science Park Drive
Singapore 118230
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
