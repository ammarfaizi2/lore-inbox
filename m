Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUJMGeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUJMGeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 02:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUJMGeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 02:34:00 -0400
Received: from virt10p.secure-wi.com ([209.216.203.97]:26322 "EHLO
	virt10p.secure-wi.com") by vger.kernel.org with ESMTP
	id S268496AbUJMGdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 02:33:55 -0400
Message-ID: <001401c4b796$abcddfb0$41c8a8c0@Eshwar>
From: "eshwar" <eshwar@moschip.com>
To: "Raj" <inguva@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar> <b2fa632f0410122315753f8886@mail.gmail.com>
Subject: Re: Write USB Device Driver entry not called
Date: Thu, 21 Oct 2004 23:22:02 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Open is sucessfull.... I don't think the problem the flags of open

Eshwar


----- Original Message ----- 
From: "Raj" <inguva@gmail.com>
To: "eshwar" <eshwar@moschip.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 13, 2004 11:45 AM
Subject: Re: Write USB Device Driver entry not called


> > 
> >   devfd = open("/dev/usb/dabusb10",O_APPEND | S_IRUSR| S_IWUSR );
> 
> Did your open() succeed here ??? i guess S_IRUSR etc is used when you
> create a new file and not when you open a new one.
> 
> >   if ( write(devfd,send,512) < 0) {
> >        printf ("write Failed\n");
> >        return  -1;
> >   }
> 
> well , if open fails above, then....
> 
> -- Raj
