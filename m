Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUELWTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUELWTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUELWTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:19:14 -0400
Received: from mail.broadpark.no ([217.13.4.2]:29905 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S261351AbUELWTN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:19:13 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Assembler warnings on Alpha
References: <yw1x1xlpv0pj.fsf@kth.se> <xlthdulpdcl.fsf@shookay.newview.com>
	<yw1xwu3htjp9.fsf@kth.se> <20040513020345.A24739@jurassic.park.msu.ru>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Thu, 13 May 2004 00:19:14 +0200
In-Reply-To: <20040513020345.A24739@jurassic.park.msu.ru> (Ivan Kokshaysky's
 message of "Thu, 13 May 2004 02:03:45 +0400")
Message-ID: <yw1xk6zhthjx.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> On Wed, May 12, 2004 at 11:32:50PM +0200, Måns Rullgård wrote:
>> Sounds promising.  I guess I'll just give it a try.  Now, does anyone
>> know what causes those warnings?
>
> For some weird reasons, the new GAS doesn't like "s" (SMALL_DATA)
> attribute for the .got section (see asm-alpha/module.h).
> These warnings are harmless. I hope the GAS will eventually be
> fixed though...

Thanks, now I won't be as nervous booting the new kernel.  New
warnings always scare me.  I've seen too much code fail on Alpha for
stupid reasons.

-- 
Måns Rullgård
mru@kth.se
