Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264383AbRFHWy7>; Fri, 8 Jun 2001 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264385AbRFHWys>; Fri, 8 Jun 2001 18:54:48 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:46095 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264383AbRFHWyj>;
	Fri, 8 Jun 2001 18:54:39 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106082254.f58MsWE487361@saturn.cs.uml.edu>
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
To: hps@intermeta.de
Date: Fri, 8 Jun 2001 18:54:32 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9fq2ce$gkb$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at Jun 08, 2001 08:29:02 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmied writes:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> So it comes down to the question of whether the module is linking
>> (which is about dependancies and requirements) and what the legal
>> scope is. Which is a matter for lawyers.
>
> And this would void DaveMs' argument, that only the "official in
> Linus' kernel published interface is allowed for binary modules". This
> would mean, that putting the posted, unofficial patch under GPL into
> the kernel and then using this interface for a binary module is just
> the same as using only the official ABI from a lawyers' point of
> view! 
>
> This would make DaveMs' position even less understandable, because
> there would be no difference for a proprietary vendor but keeping the
> patch out of the kernel makes life harder for people like the original
> poster that want to test new (open sourced) protocols like SCTP.

Yep.

Consider a chunk of x86 instructions using a home-grown OS
abstraction layer, and drivers that implement that layer for
both Linux and any non-GPL operating system. The binary blob
is obviously not derived from Linux, and may in fact run
without modification in a BSD or Solaris/x86 kernel.

There is in fact just such a layer. It might not currently
have the features needed to implement TCP, but it could be
extended as needed.



