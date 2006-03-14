Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWCNObO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWCNObO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWCNObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:31:14 -0500
Received: from mxsf24.cluster1.charter.net ([209.225.28.224]:57516 "EHLO
	mxsf24.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932172AbWCNObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:31:12 -0500
Message-ID: <4416D3AA.4070002@cybsft.com>
Date: Tue, 14 Mar 2006 08:31:06 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
Subject: Re: 2.6.16-rc6-rt3
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu>
In-Reply-To: <20060314142458.GA21796@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
>> This one doesn't want to boot on the old SMP box. Log and config attached.
> 
>>  [<c0111e19>] do_page_fault+0x36f/0x48a (88)
>>  [<c010357f>] error_code+0x4f/0x54 (76)
>>  [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
>>  [<c013321c>] simplify_symbols+0x81/0xf4 (40)
>>  [<c0133e2d>] load_module+0x637/0x968 (168)
>>  [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
>>  [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
> 
> hm, this seems to suggest some module building mismatch. Could you 
> double-check that by doing a full rebuild?
> 
> 	Ingo
> 
As noted in my response to Steve, I am doing just that.

-- 
   kr
