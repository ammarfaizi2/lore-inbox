Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131372AbRBLVty>; Mon, 12 Feb 2001 16:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131431AbRBLVtp>; Mon, 12 Feb 2001 16:49:45 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:26118 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131372AbRBLVtb>; Mon, 12 Feb 2001 16:49:31 -0500
Date: 12 Feb 2001 22:20:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7vh2HM81w-B@khms.westfalen.de>
In-Reply-To: <968mjv$l9t$1@forge.intermeta.de>
Subject: Re: DNS goofups galore...
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <20010209080454.A17656@beops-jg2.be.uu.net> <968mjv$l9t$1@forge.intermeta.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hps@tanstaafl.de (Henning P. Schmiedehausen)  wrote on 12.02.01 in <968mjv$l9t$1@forge.intermeta.de>:

> jan.gyselinck@be.uu.net (Jan Gyselinck) writes:
>
> >There's not really something wrong with MX's pointing to CNAME's.  It's
> >just that some mailservers could (can?) not handle this.  So if you want to
> >be able to receive mail from all kinds of mailservers, don't use CNAME's
> >for MX's.
>
> No. It breaks a basic assumption set in stone in RFC821. It has
> nothing to do with mailer software.

May I point out that RFC 821 does not mention either CNAME or MX anywhere.

The successor (which is currently finished and waiting for publication as  
RFC 2821) mentions both, but does not say if MX->CNAME is allowed or  
forbidden. (And it says it's tightened up from RFC 974.)

Incidentally, it's also silent on the name vs. address MX question.  
Looking at 974 and RFCs referenced from there might help to find  
ammunition. But note that this is significantly later than 821.

So don't tell us about stuff set in stone in RFC XYZ, when it's plain  
you've never looked at that RFC.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
