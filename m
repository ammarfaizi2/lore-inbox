Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbUB0Xwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUB0Xwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:52:39 -0500
Received: from [212.28.208.94] ([212.28.208.94]:274 "HELO dewire.com")
	by vger.kernel.org with SMTP id S263209AbUB0XwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:52:04 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Mobile Intel Pentium(R) 4 - M CPU 2.60GHz - kernel 2.6.3
Date: Sat, 28 Feb 2004 00:51:52 +0100
User-Agent: KMail/1.6.1
Cc: Bob Dobbs <bob_dobbs@linuxmail.org>, linux-kernel@vger.kernel.org
References: <20040227004631.31D663982E7@ws5-1.us4.outblaze.com> <Pine.LNX.4.58.0402270724530.17504@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0402270724530.17504@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402280051.53062.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 14:14, Zwane Mwaikambo wrote:
> On Fri, 27 Feb 2004, Bob Dobbs wrote:
> 
> > I am currently running kernel 2.6.3 on my Dell Inspiron 8500 laptop.
> > I disabled all the ACPI and APM options in the kernel.
Same kernel or Mandrake 10 beta which 2.6.3 + godknowswat. Acpi enabled.
whether the acpi module is actually loaded or not does not seem to affect anything,
but acpi is on according to dmesg.

> > What happens is during heavy loads my cpu drops from 2.60GHz down to
> > 1.20GHz, this happens for a few minutes, say 5 - 10 at the most. But

it doesn't appear to matter, but I have "strange" peformance problems that may
or may not be the same. Suddenly some things are very slow, welll 1.2GHz is still
fast, but..  How do I see the actual CPU frequencey? cat /proc/sys/cpu/0/* gives 
2000000 0 0 where 2GHz is max on this machine. I have not seen speed as anything
but 2GHZ.

One of the strangenesses similar to Bob's problem is that games run slow, i.e. blobwars 
have not trouble running fast on much slower machines, but on this one it runs in 
slow-motion. Another program that displays this problem is eclipse, although I don't know
if it's related.

> Just to clarify, the cpu-freq driver does not operate normally when ACPI
> is disabled? Which cpu-freq driver are you using?
> 
> > I have also tried running a program called "cpufreqd" which launches at
> > boot time, but once again without ACPI enabled in the kernel this seems
> > not to work either. Also /sys/devices/system/cpu/cpu0/cpufreq/ has the
> > following files.
> 
> Out of interest do you have CONFIG_X86_MCE_P4THERMAL enabled?
Yes.

> >
> > I tried to make those files set at: 2.00GHz min and 2.60GHz max, but
> > something changes them right back to 1.20GHZ no matter what I do.

There's a setup for enabling/disabling speedstep that says sets the frequency
to the lowest if "disabled".

-- robin
