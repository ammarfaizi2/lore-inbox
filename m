Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135869AbRDTLbj>; Fri, 20 Apr 2001 07:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135870AbRDTLb3>; Fri, 20 Apr 2001 07:31:29 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:4617 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135869AbRDTLbL> convert rfc822-to-8bit; Fri, 20 Apr 2001 07:31:11 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Francois Romieu <romieu@cogenit.fr>
Subject: Re: epic100 error
Date: Fri, 20 Apr 2001 13:30:59 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417184552.A6727@core.devicen.de> <01042010222601.06730@antares> <20010420122507.A32759@se1.cogenit.fr>
In-Reply-To: <20010420122507.A32759@se1.cogenit.fr>
MIME-Version: 1.0
Message-Id: <01042013305902.07156@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 April 2001 12:25, Francois Romieu wrote:
> Summary:
> Arnd Bergmann:
> 		orig epic100	"DMA mapped epic100 (any version)"
> 		(<=2.4.0-ac9)
> VT8363	   	ok		fscked but ok after bios update
>
> Daniel Nofftz:
> 		2.4.2		2.4.3
> VT82C595	ok		fscked. (no mention of bios experience)
>
> Oliver Teuber:
> 		2.2.19		2.4.3-ac7
> VT82C598	ok		fscked
>
> Romieu:
> 		2.2.xx		2.4.[123]
> 82443BX		ok		ok
Stefan Jaschke:
                        2.2.xx                2.4.0             2.4.3         2.4.4-pre4
AMD 761           ok                     ok                 fails          fails

# lspci
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01)
00:08.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 08)

> What happen's if you compile 2.4.2 epic100 driver in a 2.4.3 tree (I) ?
I'll try this asap.

Stefan
-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
