Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTDNMjP (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 08:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTDNMjP (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 08:39:15 -0400
Received: from web10403.mail.yahoo.com ([216.136.130.95]:10939 "HELO
	web10403.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261306AbTDNMjP (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 08:39:15 -0400
Message-ID: <20030414125104.53791.qmail@web10403.mail.yahoo.com>
Date: Mon, 14 Apr 2003 05:51:04 -0700 (PDT)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Reply-To: dj_barrow@ariasoft.ie
Subject: re mm/bootmem.c on 2.5.66 kernel suggestion
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Unless I am missing something.

I think the panics in mm/bootmem.c e.g. __alloc_bootmem should be removed
on a failed allocation of boot memory, it is not IMO a memory allocators
responsibility to panic in a low memory situation.


=====
D.J. Barrow Linux kernel developer
eMail: dj_barrow@ariasoft.ie 
Home: +353-22-47196.
Work IBM +49-7031-16-2943

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
