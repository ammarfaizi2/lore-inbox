Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132985AbRAPWna>; Tue, 16 Jan 2001 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132945AbRAPWnU>; Tue, 16 Jan 2001 17:43:20 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:36876 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S132091AbRAPWnR>;
	Tue, 16 Jan 2001 17:43:17 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Urban Widmark" <urban@teststation.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Oops with 4GB memory setting in 2.4.0 stable
Date: Wed, 17 Jan 2001 07:42:13 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGGEPLCMAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <12C574CB1236@vcnet.vc.cvut.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

	It looks like some progress is being made, *wonderful*, as to some earlier
questions...


> I'll have a look tonight or so. It works for you on non-bigmem?

Yes. Absolutely no problems on non-bigmem.


> smb_rename suggests mv, but the process is ls ... er? What commands where
> you running on smbfs when it crashed?

It seems that ANY access to the smbfs has this affect. Definitely confirmed
are: ls, tab completion from bash, cat [some file], and usually df.

>
> Could this be a symbol mismatch? Keith Owens suggested a less manual way
> to get module symbol output. Do you get the same results using that?

I'll try to do this and report back.



--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
