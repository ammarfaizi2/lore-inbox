Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936531AbWLDSDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936531AbWLDSDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936547AbWLDSDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:03:10 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:8719 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S936544AbWLDSDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:03:08 -0500
Message-ID: <45746338.7050903@ru.mvista.com>
Date: Mon, 04 Dec 2006 21:04:40 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t	in	latency_trace.c
 (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com>	<457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu> <4574149B.5070602@ru.mvista.com>
In-Reply-To: <4574149B.5070602@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>>Why is cycles_t 32-bits on some 
>>of the arches to begin with?

>     I guess this was done for speed reasons.

    The whole 64-bit timebase can't be rad atomically on PPC32. ARM probably 
has stricter limitations...

>>	Ingo

WBR, Sergei
