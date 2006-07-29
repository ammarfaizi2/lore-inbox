Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWG2Twk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWG2Twk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWG2Twj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:52:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20423 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932225AbWG2Twj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:52:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
References: <20060727015639.9c89db57.akpm@osdl.org>
	<1154112276.3530.3.camel@amdx2.microgate.com>
	<20060728144854.44c4f557.akpm@osdl.org>
	<20060728233851.GA35643@muc.de>
	<1154187239.3404.2.camel@amdx2.microgate.com>
Date: Sat, 29 Jul 2006 13:50:46 -0600
In-Reply-To: <1154187239.3404.2.camel@amdx2.microgate.com> (Paul Fulghum's
	message of "Sat, 29 Jul 2006 10:33:59 -0500")
Message-ID: <m1lkqc9omh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> writes:

> On Sat, 2006-07-29 at 01:38 +0200, Andi Kleen wrote:
>
>> It's remove-timer-fallback likely. I was working on that already.
>> 
>> Some boards go into the timer fallback path since 2.6.17/64bit for so 
>> far unknown reasons and that doesn't work anymore because I removed the 
>> fallback path.
>
> remove-timer-fallback did not reverse cleanly against 2.6.18-rc2-mm1
>
> I tried to patch it up and got it to compile without
> errors or warnings. The result was a hard freeze early in
> the boot, so I suspect more is necessary to restore that
> function.

Any chance you can post the your reversed version of remove-timer-fallback
so we can have a clue about what happened.

Eric
