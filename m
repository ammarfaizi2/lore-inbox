Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFCmQ>; Fri, 5 Jan 2001 21:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132041AbRAFCmG>; Fri, 5 Jan 2001 21:42:06 -0500
Received: from ftp.apple.asimov.net ([209.249.142.209]:61962 "HELO
	isaac.asimov.net") by vger.kernel.org with SMTP id <S129324AbRAFClr>;
	Fri, 5 Jan 2001 21:41:47 -0500
Date: Fri, 5 Jan 2001 18:41:46 -0800
From: Patrick Michael Kane <modus@pr.es.to>
To: "David S. Miller" <davem@redhat.com>
Cc: misiek@pld.ORG.PL, linux-kernel@vger.kernel.org
Subject: Re: reset_xmit_timer errors with 2.4.0
Message-ID: <20010105184146.A4853@pr.es.to>
In-Reply-To: <200101060049.QAA09715@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200101060049.QAA09715@pizda.ninka.net>; from davem@redhat.com on Fri, Jan 05, 2001 at 04:49:08PM -0800
X-Mailer: Mutt http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller (davem@redhat.com) [010105 17:08]:
>    Date: 	Fri, 5 Jan 2001 19:22:39 +0100
>    From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
> 
>    On/Dnia Fri, Jan 05, 2001 at 06:52:52AM -0800, Patrick Michael Kane wrote
>    > With 2.4.0 installed, I've started to see the following errors:
>    > 
>    > reset_xmit_timer sk=cfd889a0 1 when=0x3b4a, caller=c01e0748
>    > reset_xmit_timer sk=cfd889a0 1 when=0x3a80, caller=c01e0748
>    >
> 
>    the same problem here
> 
> Does the following patch fix this for people?
[snip]

This seems to fix it here, thanks.

Best,
-- 
Patrick Michael Kane
<modus@pr.es.to>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
