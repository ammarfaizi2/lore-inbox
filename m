Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbTDALQr>; Tue, 1 Apr 2003 06:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262333AbTDALQr>; Tue, 1 Apr 2003 06:16:47 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:9955 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262302AbTDALQr>; Tue, 1 Apr 2003 06:16:47 -0500
Date: Tue, 1 Apr 2003 12:28:00 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
Message-ID: <20030401112800.GA23027@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@suse.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com> <1049191863.30759.3.camel@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049191863.30759.3.camel@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 12:11:00PM +0200, Andi Kleen wrote:
 > sfence is part of SSE2. That's X86_SSE2

I'm not so sure this is correct. A quick google suggests
otherwise, and the C3 Nehemiah (which only supports SSE1) seems
to run sfence instructions just fine.

		Dave

