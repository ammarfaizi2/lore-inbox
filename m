Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbUBYD0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUBYD0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:26:04 -0500
Received: from fmr06.intel.com ([134.134.136.7]:55943 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262407AbUBYD0C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:26:02 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel vs AMD x86-64
Date: Tue, 24 Feb 2004 19:24:31 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA2718@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel vs AMD x86-64
Thread-Index: AcP7QhXexyRo9/qEQM6PM3x3qk4SNAACrIrw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Linus Torvalds" <torvalds@osdl.org>,
       "Adrian Bunk" <bunk@fs.tum.de>, "Herbert Poetzl" <herbert@13thfloor.at>,
       "Mikael Pettersson" <mikpe@csd.uu.se>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Feb 2004 03:24:31.0679 (UTC) FILETIME=[E227DCF0:01C3FB4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, it's not a problem. Branches with 16-bit operand size are not useful
for compilers.

Jun 
>-----Original Message-----
>From: Chris Wedgwood [mailto:cw@f00f.org]
>Sent: Tuesday, February 24, 2004 5:53 PM
>To: Nakajima, Jun
>Cc: Pavel Machek; Linus Torvalds; Adrian Bunk; Herbert Poetzl; Mikael
>Pettersson; Kernel Mailing List
>Subject: Re: Intel vs AMD x86-64
>
>On Tue, Feb 24, 2004 at 03:15:18PM -0800, Nakajima, Jun wrote:
>
>> Near branch with 66H prefix:
>>   As documented in PRM the behavior is implementation specific and
>>   should avoid using 66H prefix on near branches.
>
>Presumably this isn't a problem with current gcc's right?
>

