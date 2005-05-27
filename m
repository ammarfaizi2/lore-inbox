Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVE0GxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVE0GxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVE0GxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:53:14 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:22258 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261903AbVE0GxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:53:12 -0400
Message-ID: <007001c56290$25dd4d00$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <cutaway@bellsouth.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?
Date: Fri, 27 May 2005 03:44:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brain fade...example should be:

1) Start with AX = 0x0023
2) Execute AAM instruction
3) Now AX = 0x0305 (unpacked BCD)
4) Execute base 16 AAD instruction
5) Now AX = 0x0035 (packed BCD)

----- Original Message ----- > 
> 1) Start with AX = 0x0023
> 2) Execute AAM instruction
> 3) Now AX = 0x0203 (unpacked BCD)
> 4) Execute base 16 AAD instruction
> 5) Now AX = 0x0023 (packed BCD)

