Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSLRD3M>; Tue, 17 Dec 2002 22:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSLRD3M>; Tue, 17 Dec 2002 22:29:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265589AbSLRD3L>; Tue, 17 Dec 2002 22:29:11 -0500
Message-ID: <3DFFED33.2020201@transmeta.com>
Date: Tue, 17 Dec 2002 19:36:19 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <3014AAAC8E0930438FD38EBF6DCEB564419C95@fmsmsx407.fm.intel.com> <3DFFD55E.6020305@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> That's good to know but not what I meant.
> 
> I referred to syscall/sysret opcodes.  They are broken in their own way
> (destroying ecx on kernel entry) but at least they preserve eip.
> 

Destroying %ecx is a lot less destructive than destroying %eip and %esp...

	-hpa

