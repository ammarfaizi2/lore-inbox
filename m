Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLSVwR>; Tue, 19 Dec 2000 16:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLSVwG>; Tue, 19 Dec 2000 16:52:06 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:5124 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129406AbQLSVwD>; Tue, 19 Dec 2000 16:52:03 -0500
Date: 19 Dec 2000 21:24:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7sBg6EEXw-B@khms.westfalen.de>
In-Reply-To: <90cs2v$6u6$1@cesium.transmeta.com>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <90cs2v$6u6$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 02.12.00 in <90cs2v$6u6$1@cesium.transmeta.com>:

> Again, that's wrong even when you replace /dev/random with something
> else.  After all, you could be getting EINTR at any time, too, or get
> interrupted by a signal in the middle (in which case you'd get a short
> read.)
>
> SUCH CODE IS BROKEN.  PERIOD.  FULL STOP.

Well, one might argue that for some applications, it's sufficient to  
detect and abort such a situation.

But not checking is *never* right. Except *maybe* for a throwaway program  
whose source you erase after one use.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
