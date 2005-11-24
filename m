Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVKXPCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVKXPCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVKXPCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:02:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33480 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751283AbVKXPCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:02:22 -0500
Date: Thu, 24 Nov 2005 16:02:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch -rt] add EXPORT_PER_CPU_LOCKED_SYMBOL to asm-x86_64/percpu.h
Message-ID: <20051124150228.GB2717@elte.hu>
References: <1132236358.11652.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132236358.11652.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I was getting some module dependency problems until I found that the 
> source of these problems was that there was no 
> EXPORT_PER_CPU_LOCKED_SYMBOL in the asm-x86_64.
> 
> Here's the patch:

thanks, applied.

	Ingo
