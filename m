Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWGaFbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWGaFbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWGaFbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:31:12 -0400
Received: from colin.muc.de ([193.149.48.1]:50447 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751480AbWGaFbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:31:11 -0400
Date: 31 Jul 2006 07:31:09 +0200
Date: Mon, 31 Jul 2006 07:31:09 +0200
From: Andi Kleen <ak@muc.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
Message-ID: <20060731053109.GA14453@muc.de>
References: <20060727015639.9c89db57.akpm@osdl.org> <1154112276.3530.3.camel@amdx2.microgate.com> <20060728144854.44c4f557.akpm@osdl.org> <20060728233851.GA35643@muc.de> <1154187239.3404.2.camel@amdx2.microgate.com> <m1lkqc9omh.fsf@ebiederm.dsl.xmission.com> <44CBDB8D.3030209@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CBDB8D.3030209@microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 05:05:01PM -0500, Paul Fulghum wrote:
> Eric W. Biederman wrote:
> >>I tried to patch it up and got it to compile without
> >>errors or warnings. The result was a hard freeze early in
> >>the boot, so I suspect more is necessary to restore that
> >>function.
> >
> >
> >Any chance you can post the your reversed version of remove-timer-fallback
> >so we can have a clue about what happened.
> 
> While I'm taking the time to post my attempt at a reveresed patch,
> it would also be useful for the person who originated the
> patch to do the same. I'm not an expert on the code in
> question, so the participation of the original author
> would help speed things along.

I dropped the patch now - when Andrew resyncs his tree with
mine next time it should be fixed.

Still need to figure out the root cause though.

-Andi
