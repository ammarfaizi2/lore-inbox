Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130387AbQK0Xsg>; Mon, 27 Nov 2000 18:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129931AbQK0XsS>; Mon, 27 Nov 2000 18:48:18 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:16645 "EHLO
        mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
        id <S130319AbQK0XsK>; Mon, 27 Nov 2000 18:48:10 -0500
Date: 27 Nov 2000 23:12:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7qdCHL8Hw-B@khms.westfalen.de>
In-Reply-To: <8vrstp$o7d$1@cesium.transmeta.com>
Subject: Re: [PATCH] removal of "static foo = 0"
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <8vrstp$o7d$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 26.11.00 in <8vrstp$o7d$1@cesium.transmeta.com>:

> The problem is that it doesn't.  One could argue this is a gcc bug or
> rather missed optimization.
>
> One can, of course, also write:
>
>     static int a /* = 0 */;
>
> ... to make it clear to human programmers without making gcc make bad
> code.

This (or similar) has the added advantage of making it obvious that this  
is documentation, and not a superfluous initialization.

Sure, if you (generic you) look at your own code, you may know what it  
means if it's written a certain way. But if you look at other's code, or  
others look at your code, that is not clear. It is clear with a comment.


MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
