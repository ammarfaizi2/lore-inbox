Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263971AbRFNTEt>; Thu, 14 Jun 2001 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRFNTEk>; Thu, 14 Jun 2001 15:04:40 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:51465 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263961AbRFNTEX>;
	Thu, 14 Jun 2001 15:04:23 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106141904.f5EJ4AD413350@saturn.cs.uml.edu>
Subject: Re: Going beyond 256 PCI buses
To: davem@redhat.com (David S. Miller)
Date: Thu, 14 Jun 2001 15:04:10 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        tom_gall@vnet.ibm.com (Tom Gall), linux-kernel@vger.kernel.org
In-Reply-To: <15145.1739.395626.842663@pizda.ninka.net> from "David S. Miller" at Jun 14, 2001 11:47:39 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> Albert D. Cahalan writes:

>>    You've added an ioctl. This isn't just any ioctl. It's a
>>    wicked nasty ioctl. It's an OH MY GOD YOU CAN'T BE SERIOUS
>>    ioctl by any standard.
>
> It's an ioctl which allows things to work properly in the
> framework we currently have.

It's a hack that keeps us stuck with the existing mistakes.
We need a transition path to get us away from the old mess.

>>    Fix:
>>
>>    /proc/bus/PCI/0/0/3/0/config   config space
>
> Which breaks xfree86 instantly.  This fix is unacceptable.

Nope. Keep /proc/bus/pci until Linux 3.14 if you like.
The above is /proc/bus/PCI. That's "PCI", not "pci".
We still have /proc/pci after all.

> In fact, the current ioctl/mmap machanism was discussed with and
> agreed to by the PPC, Alpha, and Sparc64 folks.

Did you somehow miss when Linus scolded you a few weeks ago?
How about asking somebody who helps maintain /proc, like Al Viro?
