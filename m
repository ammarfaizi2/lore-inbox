Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135730AbRDXTzN>; Tue, 24 Apr 2001 15:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135732AbRDXTzF>; Tue, 24 Apr 2001 15:55:05 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:23563 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S135730AbRDXTyp>; Tue, 24 Apr 2001 15:54:45 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: axel@rayfun.org (axel), linux-kernel@vger.kernel.org
Message-ID: <86256A38.006D51DB.00@smtpnotes.altec.com>
Date: Tue, 24 Apr 2001 14:54:17 -0500
Subject: Re: compile error 2.4.4pre6: inconsistent operand constraints in
	 an
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



With the __builtin_expect patch junio@siamese.dhis.twinsun.com posted, both
2.4.4-pre6 and 2.4.3-ac12 compile with egcs-2.91.66.  Also, 2.4.3-ac13 builds
without any further patches needed.

Wayne




Alan Cox <alan@lxorguk.ukuu.org.uk> on 04/23/2001 05:58:47 PM

To:   axel@rayfun.org (axel)
cc:   linux-kernel@vger.kernel.org (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: compile error 2.4.4pre6: inconsistent operand constraints in an



> after having had trouble with compilation due to old gcc version, i have
> updated to gcc 3.0 and received the following error:

2.4.4pre6 only builds with gcc 2.96. If you apply the __builtin_expect fixes
it builds and runs fine with 2.95. Not tried egcs. The gcc 3.0 asm constraints
one I've yet to see a fix for.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





