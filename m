Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTBMBcM>; Wed, 12 Feb 2003 20:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTBMBcM>; Wed, 12 Feb 2003 20:32:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53889
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266941AbTBMBcL>; Wed, 12 Feb 2003 20:32:11 -0500
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
	due to wrmsr (performance)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Jamie Lokier <jamie@shareable.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030212181848.GA11114@wotan.suse.de>
References: <629040000.1045013743@flay>
	 <20030212025902.GA14092@codemonkey.org.uk>
	 <20030212075048.GA9049@wotan.suse.de>
	 <20030212102741.GC10422@bjl1.jlokier.co.uk>
	 <20030212104508.GA1273@wotan.suse.de>
	 <20030212185200.A629@nightmaster.csn.tu-chemnitz.de>
	 <20030212181848.GA11114@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045104126.3502.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Feb 2003 02:42:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 18:18, Andi Kleen wrote:
> > So what about making it a CONFIG_XXX option? The few dosemu users
> > could then configure it in.
> 
> Doesn't help for precompiled distribution kernels, which is what the majority
> of linux users run these days.

XFree86 makes significant use of it, and its software x86 emulator isn't up to 
replacing it on many cards (eg my C&T only works with vm86 not the emulator).
Obviously on x864-64 you have little choice, but for x86-32 its somewhat
relevant.


