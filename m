Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285673AbRLGXzd>; Fri, 7 Dec 2001 18:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285674AbRLGXzY>; Fri, 7 Dec 2001 18:55:24 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:4879 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S285673AbRLGXzL>; Fri, 7 Dec 2001 18:55:11 -0500
Message-ID: <3C1156CD.8DC2938@delusion.de>
Date: Sat, 08 Dec 2001 00:54:53 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au> <3C11394D.90101@us.ibm.com> <3C113D78.F324F1B9@delusion.de> <3C113FB1.2000AFF1@zip.com.au> <3C1147F2.4070103@us.ibm.com> <3C114E14.F6DC7937@delusion.de> <3C115196.1D5D87A5@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Hum.  send_data() requires that local interrupts be enabled.
> 
> Does this fix it?

[Patch snipped]

Yes, that fixes it. Thanks! Please submit it to Linus for inclusion
in pre7.

Regards,
Udo.
