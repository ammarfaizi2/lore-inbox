Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVAUSYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVAUSYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVAUSYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:24:12 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:47815 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S262442AbVAUSYG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:24:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: modules strip
Date: Fri, 21 Jan 2005 10:24:05 -0800
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301ACD8F7@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: modules strip
Thread-Index: AcT/5mPt4tEHv94gTeORMHSIQL6bFg==
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Jan 2005 18:24:06.0512 (UTC) FILETIME=[64650700:01C4FFE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I'm trying to strip modules a bit (2.6, x86) using

strip -R .not -R .comment --strip-unneeded module.ko

  It seems to keep intact relocation & ksymtab symbols, tested on my
configuration and seems to reduce the overall size for about 10-15%
(usefull for embedded). Does anybody know if there is any pitfalls with
that ?

Thanks,
Aleks.
