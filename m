Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271105AbTGPUV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271106AbTGPUV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:21:58 -0400
Received: from fmr05.intel.com ([134.134.136.6]:28912 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271105AbTGPUV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:21:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI patches updated (20030714)
Date: Wed, 16 Jul 2003 13:36:10 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE94@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI patches updated (20030714)
Thread-Index: AcNLf0CyROeOsYOfSPqjg1JQirv2ywAWSxTA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <hugh@veritas.com>,
       "Brown, Len" <len.brown@intel.com>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
X-OriginalArrivalTime: 16 Jul 2003 20:36:11.0160 (UTC) FILETIME=[E4971980:01C34BD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 

> Concerning code size, the 70K number in ACPI's Kconfig help is
> out of date. A minimal ACPI (all user-selectable suboptions
> disabled) adds 145K to my 2.6.0-test1 kernel.

Are you talking to the compressed or uncompressed kernel? Maybe we got
it backwards, but the 70K number was the bzImage size difference.
(Actually I just tried it again. We're 80K now. I blame gcc. ;-))

(And of course, since the kernel (incl. ACPI) dynamically allocates
memory, even the uncompressed kernel image doesn't account for the
kernel's true memory footprint...)

Regards -- Andy
