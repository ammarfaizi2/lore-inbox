Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTIBFAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbTIBFAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:00:24 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:7133 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S263493AbTIBFAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:00:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Bug in vsprintf.c - vsscanf()
Date: Tue, 2 Sep 2003 10:29:07 +0530
Message-ID: <52C85426D39B314381D76DDD480EEE0CFC69DC@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bug in vsprintf.c - vsscanf()
Thread-Index: AcNws2azWoetH66UTpeLokH+8mxfvwAWc2bQ
From: "Ramit Bhalla" <ramit.bhalla@wipro.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <alan@redhat.com>
X-OriginalArrivalTime: 02 Sep 2003 04:59:07.0995 (UTC) FILETIME=[F0CCF2B0:01C3710E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh sorry - 
It's the 2.4.19 kernel version.

Ramit.


-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org]
Sent: Monday, September 01, 2003 11:34 PM
To: Ramit Bhalla
Cc: linux-kernel@vger.kernel.org; alan@redhat.com
Subject: Re: Bug in vsprintf.c - vsscanf()


> Hi,
>
> There appears to be a bug in vsprintf.c
> The function vsscanf (if I'm correct) is the kernel mode equivalent of user
> mode sscanf. If one tries to read a hex string using the format "%x" it
> returns an error if the read buffer contains any character other than 0-9.
>
> I believe the culprit lies on line 640 of vsprintf.c
>
> It should be "isxdigit" instead of "isdigit".
>
> Hope I'm not missing anything here :)

Like what kernel version...?

If it's 2.4.x, is it recent?

~Randy




