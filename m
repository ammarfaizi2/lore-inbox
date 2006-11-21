Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWKUAoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWKUAoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWKUAoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:44:39 -0500
Received: from mail9.hitachi.co.jp ([133.145.228.44]:23696 "EHLO
	mail9.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1030588AbWKUAoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:44:38 -0500
Message-ID: <45624BF2.8040906@hitachi.com>
Date: Tue, 21 Nov 2006 09:44:34 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
Cc: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "bibo,mao" <bibo.mao@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>,
       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: Re: [PATCH][kprobe] enabling booster on the preemptible kernel
References: <455DAC83.3030505@hitachi.com> <1163775843.8789.55.camel@earth>
In-Reply-To: <1163775843.8789.55.camel@earth>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Molnar wrote:
> On Fri, 2006-11-17 at 21:35 +0900, Masami Hiramatsu wrote:
>> From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>>
>> This patch enables the kprobe-booster on the preemptible kernel.
>> For this purpose, I introduced a kind of garbage collector of
>> the instruction slots. This garbage collector checks safety before
>> releasing the garbage slots.
>>
>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> 
> 
> nice work - looks really sensible! This opens the door to djprobes (or
> rather, to the transparent kprobes speedup that used to be a separate
> interface), right?

Right. Actually, I already integrated djprobe and kprobes.
I'll post it as soon as possible.

> 
>  Acked-by: Ingo Molnar <mingo@elte.hu>

Thank you.

-- 
Masami HIRAMATSU
Linux Technology Center
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com


