Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRAOVkY>; Mon, 15 Jan 2001 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRAOVkO>; Mon, 15 Jan 2001 16:40:14 -0500
Received: from mailg.telia.com ([194.22.194.26]:25352 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S131482AbRAOVkB>;
	Mon, 15 Jan 2001 16:40:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Marcel Weber <mmweber@ncpro.com>,
        Kernel List <linux-kernel@vger.kernel.org>, gibbs@scsiguy.com
Subject: Re: [Marcel Weber <mmweber@ncpro.com>] re:Adaptec AIC7xxx version 6.08BETA release
Date: Mon, 15 Jan 2001 22:34:38 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <200101120932.KAA13634@pingu.hargarten>
In-Reply-To: <200101120932.KAA13634@pingu.hargarten>
MIME-Version: 1.0
Message-Id: <01011522343802.01217@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 January 2001 10:33, Marcel Weber wrote:
>     SuSE Linux 7.0, Kernel 2.4.0
>
>     Adaptec 3950U2
>     Adaptec 2940
>
>
>     Although the kernel is complaining about the following things:
>
>     kernel: scsi0: PCI error Interrupt at seqaddr= 0x4e
>     kernel: scsi0: Data Parity Error Detected during address or write
>     data phase
>     ...
>
>     This is compared to the original drivers already a incredible
>     change: Those freezed my system after some time (something that did
>     not happen before I upgraded from a K6-2 to a K6-2+: Apparently the
>     old driver is working with loops or something)
>

Hmm.. I start wondering if this is what I see too..
Both 2.2.18 and 2.4.0 hangs for some reason that I have not been able to 
trace down - Saturday I tried to remove all PCI cards but my 3dfx and AIC7xxx

  00:0f.0 SCSI storage controller: Adaptec AHA-7850 (rev 01) 

Has some driver been ported between 2.2 and 2.4 series recently ?
I have not seen this problem before...

I will try the new driver too...

/RogerL
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
