Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSLMPva>; Fri, 13 Dec 2002 10:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSLMPva>; Fri, 13 Dec 2002 10:51:30 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:7040 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S264956AbSLMPv3>; Fri, 13 Dec 2002 10:51:29 -0500
Date: Fri, 13 Dec 2002 17:58:59 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Mark Mielke <mark@mark.mielke.cc>,
       "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021213155859.GC1095@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Terje Eggestad <terje.eggestad@scali.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Mark Mielke <mark@mark.mielke.cc>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Dave Jones <davej@codemonkey.org.uk>
References: <1039610907.25187.190.camel@pc-16.office.scali.no> <3DF78911.5090107@zytor.com> <1039686176.25186.195.camel@pc-16.office.scali.no> <20021212203646.GA14228@mark.mielke.cc> <20021212205655.GA1658@werewolf.able.es> <1039771270.29298.41.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039771270.29298.41.camel@pc-16.office.scali.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 10:21:11AM +0100, you [Terje Eggestad] wrote:
>   
> Well, it does make sense if Intel optimized away rdtsc for more commonly
> used things, but even that don't seem to be the case. I'm measuring the
> overhead of doing a syscall on Linux (int 80) to be ~280 cycles on PIII,
> and Athlon, while it's 1600 cycles on P4.

Just out of interest, how much would sysenter (or syscall on amd) cost,
then? (Supposing it can be feasibly implemented.)

I think I heard WinXP (W2k too?) is using sysenter?


-- v --

v@iki.fi
