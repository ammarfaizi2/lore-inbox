Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTBLSFo>; Wed, 12 Feb 2003 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTBLSFo>; Wed, 12 Feb 2003 13:05:44 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:52448 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267256AbTBLSFm>; Wed, 12 Feb 2003 13:05:42 -0500
Date: Wed, 12 Feb 2003 18:52:00 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212185200.A629@nightmaster.csn.tu-chemnitz.de>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212075048.GA9049@wotan.suse.de> <20030212102741.GC10422@bjl1.jlokier.co.uk> <20030212104508.GA1273@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030212104508.GA1273@wotan.suse.de>; from ak@suse.de on Wed, Feb 12, 2003 at 11:45:08AM +0100
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18j1Pu-0003zD-00*f8kNQhNsTBI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 11:45:08AM +0100, Andi Kleen wrote:
> [...] I have no real interest in vm86 mode, perhaps one of the people
> interested in dosemu etc. could take care of it. I'm very glad it doesn't
> exist on my main architecture - x86-64 - given how many hacks it needs to be 
> supported.

So what about making it a CONFIG_XXX option? The few dosemu users
could then configure it in.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
