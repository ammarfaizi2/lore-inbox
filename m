Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTLDPV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 10:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTLDPV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 10:21:57 -0500
Received: from bay7-dav34.bay7.hotmail.com ([64.4.10.91]:4876 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262446AbTLDPVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 10:21:54 -0500
X-Originating-IP: [24.61.138.213]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Kendall Bennett" <KendallB@scitechsoft.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 4 Dec 2003 10:21:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY7-DAV34DV1amvu4600002bbe@hotmail.com>
X-OriginalArrivalTime: 04 Dec 2003 15:21:53.0647 (UTC) FILETIME=[58E1B7F0:01C3BA7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, "Linus Torvalds" wrote:

> And in fact, when it comes to modules, the GPL issue is exactly the same.
> The kernel _is_ GPL. No ifs, buts and maybe's about it. As a result,
> anything that is a derived work has to be GPL'd. It's that simple.
> ...
>  - anything that has knowledge of and plays with fundamental internal
>    Linux behaviour is clearly a derived work. If you need to muck around
>    with core code, you're derived, no question about it.


If that is the case, why the introduction of EXPORT_SYMBOL_GPL and
MODULE_LICENSE()?

Specifying explicit boundaries for the module interface has legitimised
binary-only modules.
This was the signal to developers of proprietary code that binary-only
modules are tolerable.

Note that I said tolerable, not acceptable. Ref also the 'tainted' flag
("man 8 insmod")
My personal view is that Linux should mandate GPL for all modules in 2.6 and
beyond.

The Kevin Dankwardt article gives an alternative perspective for Linux
embedded use:
http://www.linuxdevices.com/articles/AT5041108431.html
