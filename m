Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbTDAQPA>; Tue, 1 Apr 2003 11:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbTDAQPA>; Tue, 1 Apr 2003 11:15:00 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:32389 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262633AbTDAQO5>; Tue, 1 Apr 2003 11:14:57 -0500
Date: Tue, 1 Apr 2003 17:26:15 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
Message-ID: <20030401162615.GA1131@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com> <1049191863.30759.3.camel@averell> <20030401112800.GA23027@suse.de> <1049197774.31041.15.camel@averell> <Pine.LNX.4.50.0304011105540.8773-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0304011105540.8773-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 11:07:21AM -0500, Zwane Mwaikambo wrote:

 > > Yes, you're correct. It was SSE1, not SSE2.
 > > The problem Zwane encountered is that early Athlons don't support SSE1,
 > > only XP+ do
 > 
 > hmm wouldn't they illegal op? Some tested this on an Athlon 600.

I'm not 100% sure on this, but I *think* 3dnow had an sfence which was
opcode compatable with SSE's instruction.
 
		Dave
