Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUFXWCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUFXWCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUFXVrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:47:48 -0400
Received: from cdc868fe.powerlandcomputers.com ([205.200.104.254]:13030 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S265772AbUFXVos convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:44:48 -0400
content-class: urn:content-classes:message
Subject: RE: alienware hardware
Date: Thu, 24 Jun 2004 16:42:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <18DFD6B776308241A200853F3F83D5072817@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
X-MS-TNEF-Correlator: 
Thread-Topic: alienware hardware
Thread-Index: AcRaMGsoDIcwraznR62p33NdcpPGowAAPMDA
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: "Yaroslav Halchenko" <yoh@psychology.rutgers.edu>,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried booting with noapic, nolapic, noioapic and/or acpi=off? 
Unfortunately since you compiled all your drivers into the kernel, 
asking you to try without loading any of them won't work without a 
recompile.

> -----Original Message-----
> From: Yaroslav Halchenko [mailto:yoh@psychology.rutgers.edu]
> Sent: June 24, 2004 4:10 PM
> Subject: Re: alienware hardware
> 
> 
> it is seems to be more general problem, because it slows down not only
> dpkg process - booting on 2.4.26 kernel takes about 5 minutes to
> complete and of cause no dpkg is involved in that process.
> 
> I took dpkg as just single example, I don't what to try else on...
> bogomips reports about 50% of what is in /proc/cpuinfo, so it looks
> normal... I'm suspecting IDE, so it looks like when app has 
> to work with
> HDD then it slows down although HDD bulb doesn't report an 
> activity....
> but I might be wrong. btw - I will put hdparm as well on the
> webpage
> 
> We are about to setup X on that beast and I will try may be some other
> programs... suggestions?
> 
