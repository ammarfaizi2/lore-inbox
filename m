Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752055AbWFLPig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWFLPig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWFLPif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:38:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6545 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752055AbWFLPif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:38:35 -0400
From: Darren Hart <dvhltc@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Date: Mon, 12 Jun 2006 08:38:24 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <200606091701.55185.dvhltc@us.ibm.com> <200606102324.58932.dvhltc@us.ibm.com> <20060611073609.GA12456@elte.hu>
In-Reply-To: <20060611073609.GA12456@elte.hu>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606120838.25200.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 June 2006 00:36, Ingo Molnar wrote:

> ok - could you try the patch from today (re-attached below)? Maybe that
> theoretical scenario i mentioned is only theoretical in theory ;-)
>
> 	Ingo

I started running this version of the patch with prio-preemt in a loop over 10 
hours ago, and it's still running.  This seems to be the right fix.

Thanks!


-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
