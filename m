Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTLAUXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 15:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264105AbTLAUXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 15:23:40 -0500
Received: from gprs144-162.eurotel.cz ([160.218.144.162]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264104AbTLAUXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 15:23:39 -0500
Date: Mon, 1 Dec 2003 21:24:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Misha Nasledov <misha@nasledov.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APM Suspend Problem
Message-ID: <20031201202430.GB206@elf.ucw.cz>
References: <20031127062057.GA31974@nasledov.com> <20031128212853.GB8039@holomorphy.com> <20031128215008.GA2541@nasledov.com> <20031128215031.GC8039@holomorphy.com> <1070058437.2380.43.camel@laptop-linux> <20031128224928.GD8039@holomorphy.com> <20031129021712.GA13798@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129021712.GA13798@nasledov.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yeah, like I said, if I boot back into 2.4.21 it'll work just fine. I know it
> worked in -test2 and -test3 but somewhere between then and -test9 it stopped
> working. It might've been after -test3.. I haven't really looked into using
> ACPI as APM is supposed to work perfectly on my laptop and I don't want to
> complicate things.. I wish I knew more about kernel hacking so that I could
> look into this problem.

You are hitting problems in driver model... You might want to disable
calls to new driver model and see if it helps, but ultimately we want
to stop devices for APM, too.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
