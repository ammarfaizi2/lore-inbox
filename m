Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272865AbRIMFrX>; Thu, 13 Sep 2001 01:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272867AbRIMFrN>; Thu, 13 Sep 2001 01:47:13 -0400
Received: from goliath.siemens.de ([194.138.37.131]:10665 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S272865AbRIMFrE>; Thu, 13 Sep 2001 01:47:04 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel@vger.kernel.org
Subject: FW: [Cooker] rotflags and initrd
Date: Thu, 13 Sep 2001 09:46:08 +0400
Message-ID: <000201c13c17$62c86860$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru> writes:
> 
> > If kernel mounts rootfs directly, you can pass mount options via
> > rootflags boot parameter, like
> >
> > linux rootflags=data=journal
> 
> the "rootflags" kernel parameter is not documented in
> linux/Documentation/kernel-parameters.txt and I can find it in the
> whole source only at one place. I'm not sure we should honour this.

Just how "official" the parameter really is? The problem is, you want
root on reiser to be in notail mode (if you boot off root - in any case,
to avoid problems with bootloaders) and remounting reiser later AFAIK
does not change tail conversion mode.

TIA

-andrej
