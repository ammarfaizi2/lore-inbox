Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTK2CPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 21:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTK2CPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 21:15:05 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:11709
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S263600AbTK2CPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 21:15:02 -0500
Date: Fri, 28 Nov 2003 18:17:12 -0800
To: William Lee Irwin III <wli@holomorphy.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APM Suspend Problem
Message-ID: <20031129021712.GA13798@nasledov.com>
References: <20031127062057.GA31974@nasledov.com> <20031128212853.GB8039@holomorphy.com> <20031128215008.GA2541@nasledov.com> <20031128215031.GC8039@holomorphy.com> <1070058437.2380.43.camel@laptop-linux> <20031128224928.GD8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128224928.GD8039@holomorphy.com>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, like I said, if I boot back into 2.4.21 it'll work just fine. I know it
worked in -test2 and -test3 but somewhere between then and -test9 it stopped
working. It might've been after -test3.. I haven't really looked into using
ACPI as APM is supposed to work perfectly on my laptop and I don't want to
complicate things.. I wish I knew more about kernel hacking so that I could
look into this problem.

On Fri, Nov 28, 2003 at 02:49:28PM -0800, William Lee Irwin III wrote:
> On Sat, Nov 29, 2003 at 11:27:17AM +1300, Nigel Cunningham wrote:
> > Dunno if I'm an expert, but I might be able to help. None of the Linux
> > based suspends (2.4 or 2.6) will get started unless something like acpid
> > pushes them. If a laptop suspends without running acpid or similar, it
> > must be doing it from the BIOS.
> 
> apmd is running, though I don't know if it's the one doing it.
> 
> It also seems to be dependent on CONFIG_APM.

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
