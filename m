Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136583AbREAH2E>; Tue, 1 May 2001 03:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136585AbREAH1y>; Tue, 1 May 2001 03:27:54 -0400
Received: from webmailstation.com ([208.231.7.197]:60959 "HELO
	mx.webmailstation.com") by vger.kernel.org with SMTP
	id <S136583AbREAH1j> convert rfc822-to-8bit; Tue, 1 May 2001 03:27:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: DPT I2O RAID and Linux I2O
Date: Tue, 1 May 2001 14:29:08 +0700
X-Mailer: KMail [version 1.2.2]
In-Reply-To: <E14uOrh-0000sV-00@the-village.bc.nu>
In-Reply-To: <E14uOrh-0000sV-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010501071937.533F71C86C@mx.webmailstation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 May 2001 08:22, Alan Cox wrote:
> A few people have asked about the dpt_i2o driver recently. If you have a
> DPT I2O card please try a late 2.4.3-ac kernel. It should now work when you
> do 'modprobe i2o_scsi'

Which cards are you talking about? Is SmartRAID V is in the list?

> After a lot of reviewing of the dpt driver I figured out what command was
> upsetting the beast and added a workaround for it. I also fixed a pile of
> bugs in the drivers that caused failed table queries to corrupt memory
> in some cases (the DPT tended to trigger these and so made the box reboot
> if you used i2oproc or i2oconfig.
>
> I'd also like to say thanks to DPT (now Adaptec) for supplying me with a
> card which meant that in combination with their driver I was eventually
> able to figure out the cure.
>
> More feedback from DPT i2o raid card users would be useful
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
