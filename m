Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132550AbRDAUSY>; Sun, 1 Apr 2001 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRDAUSP>; Sun, 1 Apr 2001 16:18:15 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:46096 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132550AbRDAUSF>;
	Sun, 1 Apr 2001 16:18:05 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104012017.f31KH0D272253@saturn.cs.uml.edu>
Subject: Re: bug database braindump from the kernel summit
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 1 Apr 2001 16:17:00 -0400 (EDT)
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <001c01c0bae2$e523fc90$5517fea9@local> from "Manfred Spraul" at Apr 01, 2001 09:32:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul writes:
> [Larry McVoy]

>> There was a lot of discussion about possible tools
>> that would dig out the /proc/pci info
>
> I think the tools should not dig too much information out of the system.
> I remember some Microsoft (win98 beta?) bugtracking software that
> insisted on sending a several hundert kB long compressed blob with every
> bug report.
> IMHO it must be possible to file bugreports without the complete hw info
> if I know that the bug isn't hw related.

Yep. The two hardware-related items that usually matter:

Little-endian or broken-endian?
32-bit or 64-bit?

The CPU type is not necessary or sufficient, since one can often
run a 32-bit kernel on 64-bit hardware and at least MIPS has both
little-endian and broken-endian supported.
