Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVKSV4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVKSV4b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVKSV4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:56:31 -0500
Received: from khc.piap.pl ([195.187.100.11]:32260 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750928AbVKSV4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:56:31 -0500
To: Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp>
Cc: laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: build bug: ipt_CONNMARK.c: undefined reference to
 `need_ip_conntrack'
References: <m364qolfuv.fsf@defiant.localdomain>
	<200511191930.jAJJUJEv022269@toshiba.co.jp>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 19 Nov 2005 22:56:23 +0100
In-Reply-To: <200511191930.jAJJUJEv022269@toshiba.co.jp> (Yasuyuki KOZAKAI's
 message of "Sun, 20 Nov 2005 04:30:18 +0900 (JST)")
Message-ID: <m3wtj42tfc.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp> writes:

>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> net/built-in.o(.init.text+0x1adb): In function `init':
>> ipt_CONNMARK.c: undefined reference to `need_ip_conntrack'
>> make[2]: *** [.tmp_vmlinux1] Error 1
>> 
>> Last merged Linus' git: b286e39207237e2f6929959372bf66d9a8d05a82
>> (i.e., current 2.6.15rc1+).
>
> Thanks for report. Could you check this patch ?

Builds correctly. Thanks.
-- 
Krzysztof Halasa
