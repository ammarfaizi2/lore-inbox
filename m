Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277282AbRJJPk2>; Wed, 10 Oct 2001 11:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277285AbRJJPkT>; Wed, 10 Oct 2001 11:40:19 -0400
Received: from magic.adaptec.com ([208.236.45.80]:7340 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S277278AbRJJPkI>;
	Wed, 10 Oct 2001 11:40:08 -0400
Message-ID: <F4C5F64C4EBBD51198AD009027D61DB31C813A@otcexc01.otc.adaptec.com>
From: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
To: "'jkniiv@hushmail.com'" <jkniiv@hushmail.com>,
        linux-kernel@vger.kernel.org
Subject: RE: Dilemma: Replace Escalade with Adaptec 2400A or Promise Super
	trak66?
Date: Wed, 10 Oct 2001 11:40:32 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H
 The Adaptec 2400A is presumably very much like the 2100S SCSI 
> model. Adaptec has released some binary only drivers and 
> utilities but none for the 2.4 kernel line. 

Our drivers are completely open source and currently embedded in both the AC
and Linus kernel and shipping with various distributions.  They have been
completely qualified with our product verification lab (i.e. not beta).  It
is the exact same driver across all of the i2o raid products, whether it is
SCSI or ATA.  The i2o interface is the same and ATA drives/arrays appear to
the OS as sd devices.  

When changing adapters you will not just be able to plug the drives into the
Adaptec card and go.  The raid tables and striping will be different.  The
Adaptec metadata formats are public, I have not looked into the 3ware format
though.  If there is enough interest we can explore creating a conversion
program.

Deanna
