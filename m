Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVGHT7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVGHT7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVGHT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:57:10 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:1672 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262835AbVGHTzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:55:17 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Fri, 8 Jul 2005 20:55:24 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu>
In-Reply-To: <20050708194827.GA22536@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507082055.24116.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jul 2005 20:48, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Unfortunately I see nothing like this when the machine crashes. Find
> > attached my config, which has CONFIG_4KSTACKS and the options you
> > specified. Are you sure this is sufficient to enable it?
>
> i have booted your .config, and stack overflow debugging is active and
> working. So it probably wasnt a straight (detectable) stack recursion /
> stack footprint issue.
>

Ingo,

Your first guess was accurate, I hadn't realised these messages were a lower 
log level than BUG: or the oops, so I wasn't watching them. Disabling quiet 
now, I'll try to address all your queries in a timely fashion.

We're getting closer anyway, I feel.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
