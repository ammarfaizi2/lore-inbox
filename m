Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbTCYTAC>; Tue, 25 Mar 2003 14:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263199AbTCYTAC>; Tue, 25 Mar 2003 14:00:02 -0500
Received: from fmr02.intel.com ([192.55.52.25]:40153 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263195AbTCYTAB> convert rfc822-to-8bit; Tue, 25 Mar 2003 14:00:01 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: unsupported bridge with intel E7205 chipset 
Date: Tue, 25 Mar 2003 10:40:25 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00143B6FF@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: unsupported bridge with intel E7205 chipset 
Thread-Index: AcLyw7ndw8FBA+geS3ipXZH5jnHXdgAOfJEg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: <imre@molnar.info>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Mar 2003 18:40:27.0083 (UTC) FILETIME=[00EB49B0:01C2F2FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After booting with the latest stable kernel (2.4.20):
> -----------------------dmesg---------------------------
> .			 :
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 1919M
> agpgart: Unsupported Intel chipset (device id: 255d), you might want
> to try agp_try_unsupported=1.
> agpgart: no supported devices found.
> ........................:............................ 
> 
> I found a patch under:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.3/0584.html
> 
> After patched the kernel:
> -------------------------dmesg------------------------
> .			   :
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 1919M
> agpgart: unsupported bridge
> agpgart: no supported devices found.
> .........................:...........................
> 
> The motherboard is from Asus (P4G8X-Deluxe):
> o  North bridge controller: E7205
> o  South bridge controller: ICH4
> 
> How is this problem to solve?
> 

Hi,

I posted another patch after that one that also incorporated the E7205 host bridge.  I'll resend to you directly....

thanks,
matt
