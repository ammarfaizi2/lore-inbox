Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTEPDpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 23:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTEPDpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 23:45:36 -0400
Received: from ms-smtp-03.southeast.rr.com ([24.93.67.84]:3039 "EHLO
	ms-smtp-03.southeast.rr.com") by vger.kernel.org with ESMTP
	id S264346AbTEPDpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 23:45:35 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: linux-kernel@vger.kernel.org
Subject: The kernel is miscalculating my RAM...
Date: Fri, 16 May 2003 00:03:25 -0400
User-Agent: KMail/1.5.1
References: <200305131415.37244.techstuff@gmx.net> <200305140650.h4E6oCu04880@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200305140650.h4E6oCu04880@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305160003.25262.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok here is what dmesg shows:
384MB LOWMEM available.

then further down:
Memory: 385584k/393216k available (2010k kernel code, 7244k reserved, 597k 
data, 128k init, 0k highmem)

now how is the little 38.../39... possible? 

and then top shows this:
Mem:    385712k total

this again is different than the others...

and finaly gkrellm is telling me that I have only 377 mb actually recognized 
out of the 384mb that the kernel detected above...

So the question is where does my 7mb go, why that weird 38.../39 difference 
and why does top report another different value.
