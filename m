Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWAYUD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWAYUD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWAYUD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:03:27 -0500
Received: from fmr22.intel.com ([143.183.121.14]:696 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751191AbWAYUDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:03:23 -0500
Message-Id: <200601252002.k0PK2Mg31276@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Geert Uytterhoeven'" <geert@linux-m68k.org>
Cc: "Akinobu Mita" <mita@miraclelinux.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
       <parisc-linux@parisc-linux.org>,
       "Linux/PPC Development" <linuxppc-dev@ozlabs.org>,
       <linux390@de.ibm.com>, <linuxsh-dev@lists.sourceforge.net>,
       <sparclinux@vger.kernel.org>, <ultralinux@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
Subject: RE: [PATCH 5/6] fix warning on test_ti_thread_flag()
Date: Wed, 25 Jan 2006 12:02:21 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYh1Bebb4coZgsRSsmAghhIjqO4xgAFVNHw
In-Reply-To: <Pine.LNX.4.62.0601251814350.19174@pademelon.sonytel.be>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote on Wednesday, January 25, 2006 9:19 AM
> > I don't think you need to change the flags size.
> 
> Passing a pointer to a 32-bit entity to a function that takes a
> pointer to a 64-bit entity is a classical endianness bug. So it's
> better to change it, before people copy the code to a big endian
> platform.

Well, x86-64 and linux-ia64 both use little endian.  I don't
understand why you are barking at us with big endian issue.

- Ken


Side-note: cc list trimmed.


