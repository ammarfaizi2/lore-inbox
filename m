Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUGLOPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUGLOPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUGLOPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:15:32 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39040 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266185AbUGLOPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:15:31 -0400
Message-ID: <40F29CF9.4000400@nortelnetworks.com>
Date: Mon, 12 Jul 2004 10:15:21 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040711143853.GA6555@elte.hu>
In-Reply-To: <20040711143853.GA6555@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> it was reporting more accurate latencies, except that there were strange
> spikes of latencies. It turned out that for whatever reason, userspace
> RDTSC is not always reliable on my box (!).

Would the fact that rdtsc is not serializing have any effect here?  Or would 
that be a small enough error to not have any effect?

Chris
