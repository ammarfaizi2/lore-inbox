Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbSLEJ2u>; Thu, 5 Dec 2002 04:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbSLEJ2u>; Thu, 5 Dec 2002 04:28:50 -0500
Received: from holomorphy.com ([66.224.33.161]:21897 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267253AbSLEJ2s>;
	Thu, 5 Dec 2002 04:28:48 -0500
Date: Thu, 5 Dec 2002 01:35:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021205093559.GH9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Russell King <rmk@arm.linux.org.uk>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <20021205092523.GG9882@holomorphy.com> <20021204222039.A12956@flint.arm.linux.org.uk> <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey> <20021204124227.GB647@suse.de> <20021204183235.GA701@gallifrey> <3536.1039079718@passion.cambridge.redhat.com> <3907.1039080862@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3907.1039080862@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com said:
>>  Is there any chance you can send a testcase my way? I've got some
>> testboxen that are good at bringing out races (NUMA stuff is beautiful
>> for that -- I don't consider anything racetested until it passes
>> there.) 

On Thu, Dec 05, 2002 at 09:34:22AM +0000, David Woodhouse wrote:
> The race in vmalloc is purely theoretical but blatantly obvious -- I don't
> think anyone's actually triggered it though. You have already tried the fix
> and reported it works fine. Apparently for akpm ioremap() returns a 
> bogus value to the aic7xxx driver and the box locks up. I can't see why it 
> could do that -- more eyes welcome...

I'm sorry, that's already so; acked as it stands from prior testing, and
excellent auditwork on your part to boot.


Thanks,
Bill
