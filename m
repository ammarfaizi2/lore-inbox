Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272729AbTHKPqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272741AbTHKPqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:46:54 -0400
Received: from holomorphy.com ([66.224.33.161]:38312 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272729AbTHKPqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:46:52 -0400
Date: Mon, 11 Aug 2003 08:47:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rob Landley <rob@landley.net>
Cc: Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
Message-ID: <20030811154740.GD32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rob Landley <rob@landley.net>, Nick Piggin <piggin@cyberone.com.au>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <200308110248.09399.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308110248.09399.rob@landley.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 06:32, Nick Piggin wrote:
>> But by employing the kernel's services in the shape of a blocking
>> syscall, all sleeps are intentional.

On Mon, Aug 11, 2003 at 02:48:09AM -0400, Rob Landley wrote:
> Wrong.  Some sleeps indicate "I have run out of stuff to do right now, I'm 
> going to wait for a timer or another process or something to wake me up with 
> new work".
> Some sleeps indicate "ideally this would run on an enormous ramdisk attached 
> to gigabit ethernet, but hard drives and internet connections are just too 
> slow so my true CPU-hogness is hidden by the fact I'm running on a PC instead 
> of a mainframe."
> There is are "I have nothing to do right now, and I'm okay with that" sleeps, 
> and there are "I have requested more work, and it should hurry up and get 
> here" sleeps.

Perhaps more apps should use aio.


-- wli
