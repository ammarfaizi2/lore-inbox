Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSLEJSU>; Thu, 5 Dec 2002 04:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbSLEJSU>; Thu, 5 Dec 2002 04:18:20 -0500
Received: from holomorphy.com ([66.224.33.161]:16265 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264647AbSLEJSU>;
	Thu, 5 Dec 2002 04:18:20 -0500
Date: Thu, 5 Dec 2002 01:25:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021205092523.GG9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Russell King <rmk@arm.linux.org.uk>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <20021204222039.A12956@flint.arm.linux.org.uk> <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey> <20021204124227.GB647@suse.de> <20021204183235.GA701@gallifrey> <3536.1039079718@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3536.1039079718@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmk@arm.linux.org.uk said:
>>  Oh, not to mention the inherently racy code found within mm/vmalloc.c

On Thu, Dec 05, 2002 at 09:15:18AM +0000, David Woodhouse wrote:
> A fix for that was sent to Linus months ago. Akpm says it breaks, nobody 
> else can reproduce the breakage and I can't see a problem with it...

Is there any chance you can send a testcase my way? I've got some
testboxen that are good at bringing out races (NUMA stuff is beautiful
for that -- I don't consider anything racetested until it passes there.)

No guarantees, of course, but I do like to make my testing services
available when I can. Recently it helped with some of kai's makefiles.


Thanks,
Bill
