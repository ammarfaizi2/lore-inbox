Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTK2CUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 21:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTK2CUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 21:20:20 -0500
Received: from holomorphy.com ([199.26.172.102]:32196 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263607AbTK2CUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 21:20:16 -0500
Date: Fri, 28 Nov 2003 18:20:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Misha Nasledov <misha@nasledov.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APM Suspend Problem
Message-ID: <20031129022005.GE8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Misha Nasledov <misha@nasledov.com>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031127062057.GA31974@nasledov.com> <20031128212853.GB8039@holomorphy.com> <20031128215008.GA2541@nasledov.com> <20031128215031.GC8039@holomorphy.com> <1070058437.2380.43.camel@laptop-linux> <20031128224928.GD8039@holomorphy.com> <20031129021712.GA13798@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129021712.GA13798@nasledov.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 02:49:28PM -0800, William Lee Irwin III wrote:
>> apmd is running, though I don't know if it's the one doing it.
>> It also seems to be dependent on CONFIG_APM.

On Fri, Nov 28, 2003 at 06:17:12PM -0800, Misha Nasledov wrote:
> Yeah, like I said, if I boot back into 2.4.21 it'll work just fine. I know it
> worked in -test2 and -test3 but somewhere between then and -test9 it stopped
> working. It might've been after -test3.. I haven't really looked into using
> ACPI as APM is supposed to work perfectly on my laptop and I don't want to
> complicate things.. I wish I knew more about kernel hacking so that I could
> look into this problem.

I haven't used the CONFIG_SOFTWARE_SUSPEND needed for ACPI much; AIUI
it's still prototypical in various ways (or whatever the right way to
phrase that is), and I'm a bit too overextended to help out with it now.

There is an oddity I forgot to report: it doesn't suspend when I close
the lid if I still have the power plugged in. Also, I tried the suspend
button, and it works perfectly fine here for both suspend and resume on
a standard LTC issue Stinkpad T21, again with the power cord proviso.


-- wli
