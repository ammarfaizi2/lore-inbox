Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264642AbUETGt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264642AbUETGt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 02:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUETGt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 02:49:59 -0400
Received: from p3EE062C3.dip0.t-ipconnect.de ([62.224.98.195]:1922 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S264642AbUETGt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 02:49:58 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: 2.6.6-mm4
Date: Thu, 20 May 2004 07:44:32 +0200
Organization: privat
Message-ID: <c8hgk0$336$1@p3EE062C3.dip0.t-ipconnect.de>
References: <fa.h0r5q8q.k6meb8@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.h0r5q8q.k6meb8@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I got a compile error compiling the following:

   LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x1247f): In function `hpet_rtc_interrupt':
: undefined reference to `rtc_interrupt'
arch/i386/kernel/built-in.o(.text+0x124aa): In function `hpet_rtc_interrupt':
: undefined reference to `rtc_get_rtc_time'
make: *** [.tmp_vmlinux1] Error 1

I switched on 'HPET Timer Support' and 'Provide RTC interrupt'
It works fine without 'Provide RTC interrupt'.


I'm using gcc 3.3.3 and binutils 2.15.90.0.3.


Regards,
Andreas Hartmann
