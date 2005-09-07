Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVIGJVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVIGJVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVIGJVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:21:12 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:60295 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S1751185AbVIGJVL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:21:11 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: kbuild & C++
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Wed, 7 Sep 2005 11:13:24 +0200
Message-ID: <809C13DD6142E74ABE20C65B11A2439809C4BE@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kbuild & C++
Thread-Index: AcWzNfrIfCiZ2FNESH+4jAM4+CvINwAVXBdQ
From: "Budde, Marco" <budde@telos.de>
To: "Esben Nielsen" <simlo@phys.au.dk>, "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> That would be because the kernel is written in *C* (and some asm),
*not* C++.

I cannot see the connection. At the end everything gets converted
to assembler/opcode. In the user space I can mix C and C++ code
without any problems, why should this not be possible in the
kernel mode?

>> There /is/ no C++ support.

This will be a problem in future. Nearly nobody will start a new
larger project (driver, user space software, embedded firmware)
using non OO languages today. So porting eg. Windows drivers to
Linux is nearly impossible without C++ support.

E.g. in my case the Windows source code has got more than 10 MB.
Nobody will convert such an amount of code from C++ to C.
This would take years.

> I think it can only be a plus to Linux to add C++ support for at least
> out-of-mainline drivers. Adding drivers written in C++ into the
mainline
> is another thing.

Right.

cu, Marco

