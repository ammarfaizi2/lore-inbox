Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSGGA2S>; Sat, 6 Jul 2002 20:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSGGA2R>; Sat, 6 Jul 2002 20:28:17 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2568 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S314096AbSGGA2R>;
	Sat, 6 Jul 2002 20:28:17 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207070030.g670UbT166497@saturn.cs.uml.edu>
Subject: Re: [OT] /proc/cpuinfo output from some arch
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 6 Jul 2002 20:30:37 -0400 (EDT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20020707002006.B5242@flint.arm.linux.org.uk> from "Russell King" at Jul 07, 2002 12:20:06 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> On Sat, Jul 06, 2002 at 03:16:07PM -0700, H. Peter Anvin wrote:

>> /proc/cpuinfo was *definitely* meant to be parsed by programs.
>> Unfortunately, lots of architectures seems to have completely missed
>> that fact.
>
> Sigh, its a shame such things aren't documented somewhere in the
> kernel tarball.

Ah, but you're supposed to remember the history!
The colons were added to make parsing easier.
I think that was done after somebody added spaces
on the left, and lots of app developers screamed
that the format had become hopeless.

Right now I'm looking to get the temperature,
clock speed, and voltage. I get the first two
on PowerPC hardware, but it's not obvious what
mess an SMP system would spit out.


