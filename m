Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135325AbRD1Pov>; Sat, 28 Apr 2001 11:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135331AbRD1Pol>; Sat, 28 Apr 2001 11:44:41 -0400
Received: from mail2.netcabo.pt ([212.113.161.137]:56070 "EHLO netcabo.pt")
	by vger.kernel.org with ESMTP id <S135325AbRD1Po0> convert rfc822-to-8bit;
	Sat, 28 Apr 2001 11:44:26 -0400
From: =?iso-8859-1?Q?Andr=E9_Cruz?= <afafc@rnl.ist.utl.pt>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
Date: Sat, 28 Apr 2001 16:46:40 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAArqXyEnDnsk6P8VUX1zHRj8KAAAAQAAAApXyGRgClh0mFu83phfapSQEAAAAA@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have this problem. The first time dhcpcd is executed it fails due
to timeout. 
If we execute it again it works fine. Looks like the first packets
sent/received through the interface don't get treated right. 
If I reverse the 2.4.4 patch to 2.4.3 it starts working well again.
Something's up with the realtek driver update I would say.

I'm not on the list so please CC me replys.
Thanks.

------------
André Cruz

