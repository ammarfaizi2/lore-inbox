Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTGZTEG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbTGZTEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:04:06 -0400
Received: from holomorphy.com ([66.224.33.161]:14781 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S267724AbTGZTED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:04:03 -0400
Date: Sat, 26 Jul 2003 12:20:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org, mingo@elte.hu
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030726192027.GA15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
	mingo@elte.hu
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de> <20030726181913.GY15452@holomorphy.com> <1059244278.576.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059244278.576.0.camel@teapot.felipe-alfaro.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 20:19, William Lee Irwin III wrote:
>> I've no plausible explanation for this; perhaps the only possible one
>> is that one of the algorithms that was sped up was behaving badly enough
>> to interfere with scheduling.

On Sat, Jul 26, 2003 at 08:31:18PM +0200, Felipe Alfaro Solana wrote:
> I've also noticed that 2.6.0-test1-wl1A behaves pretty well, given that
> no major changes to the CPU scheduler are included.

Okay, now there's a question of narrowing down which piece of it did
it. It consists of 38 or so pieces so 6 boots should do it.


-- wli
