Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132357AbQLHRHm>; Fri, 8 Dec 2000 12:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbQLHRHd>; Fri, 8 Dec 2000 12:07:33 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:7186 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S132356AbQLHRHP>; Fri, 8 Dec 2000 12:07:15 -0500
Message-ID: <3A310E18.DD23D416@home.com>
Date: Fri, 08 Dec 2000 10:36:40 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com> <Pine.LNX.3.95.1001207205043.5530A-100000@chaos.analogic.com> <20001207200415.O6567@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Dick Johnson]
> > Do:
> >
> > char main[]={0xff,0xff,0xff,0xff};
> 
> Oh come on, at least pick an *interesting* invalid opcode:
> 
>   char main[]={0xf0,0x0f,0xc0,0xc8};    /* try also on NT (: */
> 

me2v@reliant DRFDecoder $ ./op
Illegal instruction (core dumped)

Is that the expected behavior?

-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
