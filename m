Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWCUUIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWCUUIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWCUUIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:08:38 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:30880 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751759AbWCUUIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:08:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=P+kroTxsK+UFpnnflrhTMnBJ8OULvNk0EW7gxPosgXkxZZwUCAz1mROy+ddD185Dy1mnfJ3F8VgLki5njsRXDSxIyNBejGeiZyC7IEOT7/blSODo1Bql0bWpmoLLw/qMas8GXN2gDl21Wi+o+QneBCG0MlNv08HC/V6rgbNGw78=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Vadim Lobanov'" <vlobanov@speakeasy.net>,
       "'H. Peter Anvin'" <hpa@zytor.com>
Cc: "'Jan Engelhardt'" <jengelh@linux01.gwdg.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: VFAT: Can't create file named 'aux.h'?
Date: Tue, 21 Mar 2006 12:05:55 -0800
Message-ID: <000301c64d22$dd94ef70$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.58.0603211154530.31582@shell3.speakeasy.net>
Thread-Index: AcZNIjDTe14LBprhQyq7qRCgxxzPVwAAJSOA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's more "treating aux.* the same way as aux". It doesn't fail per se. If
you do "echo test >con.h", it will print to the screen.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Vadim Lobanov
> Sent: Tuesday, March 21, 2006 11:55 AM
> To: H. Peter Anvin
> Cc: Jan Engelhardt; linux-kernel@vger.kernel.org
> Subject: Re: VFAT: Can't create file named 'aux.h'?
> 
> On Tue, 21 Mar 2006, H. Peter Anvin wrote:
> 
> > Jan Engelhardt wrote:
> > >>>>You're confusing characters which aren't legal *VFAT* names which
> those
> > >>>>which
> > >>>>aren't legal *FAT* (8.3) names.
> > >>>
> > >>>Could you please name an illegal FAT name being legal VFAT name?
> > >>
> > >>"Green Furry Submarine"
> > >>
> > >
> > > Ah well. But aux.h is also forbidden under VFAT, is not it? Or no,
> because
> > > it's "just" an 8.3 name?
> > >
> >
> > It probably depends on how picky you want to be.  As far as I know, even
> > NT will recognize a character device name without leaving \DEV\, even
> > though \DEV\ has been the "official" device prefix since DOS 2.0.
> >
> > Probably it would be worth trying to create "aux.h" under XP and see
> > what happens.  Unfortunately I don't have a 'doze system handy at the
> > moment.
> 
> Fails silently.
> 
> > 	-hpa
> >
> > -
> 
> Vadim Lobanov
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

