Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTDJObi (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTDJObi (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:31:38 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:63408 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264054AbTDJObg (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 10:31:36 -0400
To: mikpe@csd.uu.se
Cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: gcc-2.95 broken on PPC? 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-reply-to: Your message of "Thu, 10 Apr 2003 14:56:28 +0200."
             <200304101256.h3ACuSw3022796@harpo.it.uu.se> 
Date: Thu, 10 Apr 2003 16:42:46 +0200
Message-Id: <20030410144251.9B83CC5877@atlas.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200304101256.h3ACuSw3022796@harpo.it.uu.se> you wrote:
> 
> It seems gcc-2.95, specifically 2.95.4 as included in YDL2.3,
> generates incorrect code for recent 2.4 standard kernels on PPC.

Ummm.. do you have any direct evidence, i. e. a source file where the
generated object code is obviously wrong?

> However, bugs #1 (zlib.c) and #3 (div64.h) disappear if I compile
> my kernels with gcc-3.2.2 instead of 2.95.4, which is a strong
> indication that 2.95.4 is broken on PPC. Is this something that's

This is speculation only. We use gcc-2.95.4 as part of  our  ELDK  in
all  of our projects, and a lot of people are using these tools, too.
We definitely see more problems with gcc-3.x compilers.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Overflow on /dev/null, please empty the bit bucket.
