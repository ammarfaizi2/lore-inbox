Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbRAYPA0>; Thu, 25 Jan 2001 10:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130968AbRAYPAH>; Thu, 25 Jan 2001 10:00:07 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:48390 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129291AbRAYO7t>; Thu, 25 Jan 2001 09:59:49 -0500
Date: 25 Jan 2001 15:33:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7uYrAXlHw-B@khms.westfalen.de>
In-Reply-To: <3A6E2C6E.632CDABF@coppice.org>
Subject: Re: [OT?] Coding Style
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3A6E2C6E.632CDABF@coppice.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steveu@coppice.org (Steve Underwood)  wrote on 24.01.01 in <3A6E2C6E.632CDABF@coppice.org>:

> Unfortunately the C standards people don't seem to realise there are
> languages other than English. C99 had perfect timing to introduce UTF8
> Unicode as acceptable in C source. Alas they missed the boat. I have
> been embedding Chinese in C source for years (mostly Big-5 -  UTF8 is
> more likely to be troublesome with existing compilers), and have yet to
> hit a significant problem. It isn't standards compliant, though.

Have you *READ* the C99 standard? According to my copy of ISO/IEC  
9899:1999, chinese characters in identifiers are quite legal.

And the source is not defined to be UTF8 because C has never defined the  
source to be any specific character set; if your character set does not  
include the right characters, use \uXXXX or \Uxxxxxxxx.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
