Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136686AbREASgB>; Tue, 1 May 2001 14:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136687AbREASfv>; Tue, 1 May 2001 14:35:51 -0400
Received: from tomts2.bellnexxia.net ([209.226.175.140]:54738 "EHLO
	tomts2-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S136686AbREASfo>; Tue, 1 May 2001 14:35:44 -0400
From: "Patrick Allaire" <patrick.allaire@isaacnewtontech.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: DPT I2O RAID and Linux I2O
Date: Tue, 1 May 2001 14:34:51 -0400
Message-ID: <HEEIIHGBKLFOBPOOOJHCOEPKCGAA.patrick.allaire@isaacnewtontech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E14uOrh-0000sV-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is this I2O implementation supporting PCI devices ?

Yesterday I post something about that, I have a CompactPCI computer with 2
computers in it. One master and one slave. The slave one, is has a non
transparent pci-to-pci bridge : DEC (INTEL) 21554, wich support I2O
messaging, I want both computer to communicate by this mean, but I cant seam
to be able to make the I2O working, I was trying on 2.2.19 ... but I will
try on 2.4.4. But is there allready a device who is doing this kind of
communication, I would like to look a some code to see how htis I2O is
working. I have looked a some docs, but I didnt find any ... I guess I will
be stuck with reading all the I2O specs from the SIG.

Thank you for your time.





> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]De la part de Alan Cox
> Envoye : April 30, 2001 9:22 PM
> A : linux-kernel@vger.kernel.org
> Objet : DPT I2O RAID and Linux I2O
>
>
> A few people have asked about the dpt_i2o driver recently. If you
> have a DPT
> I2O card please try a late 2.4.3-ac kernel. It should now work when you do
> 'modprobe i2o_scsi'
>
> After a lot of reviewing of the dpt driver I figured out what command was
> upsetting the beast and added a workaround for it. I also fixed a pile of
> bugs in the drivers that caused failed table queries to corrupt memory
> in some cases (the DPT tended to trigger these and so made the box reboot
> if you used i2oproc or i2oconfig.
>
> I'd also like to say thanks to DPT (now Adaptec) for supplying me
> with a card
> which meant that in combination with their driver I was eventually able to
> figure out the cure.
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

