Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293547AbSBZJQm>; Tue, 26 Feb 2002 04:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293550AbSBZJQc>; Tue, 26 Feb 2002 04:16:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293547AbSBZJQa>; Tue, 26 Feb 2002 04:16:30 -0500
Subject: Re: Submissions for 2.4.19-pre [x86 Syscall Optimizations (Alexander Khripin)]
To: me@ohdarn.net (Michael Cohen)
Date: Tue, 26 Feb 2002 09:31:09 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <20020225222653.5d1a1d27.me@ohdarn.net> from "Michael Cohen" at Feb 25, 2002 10:26:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fdwz-0008SJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Eh?  The patch doesn't do anything but move movl ops around.  I suspect
> > the intention may to eliminate datapath stalls, which may be a fine
> > micro-optimization, but I think we need some numbers first ...
> 
> UNIXbench numbers on the way :)

Remember to get them with more than one vendor and family of processors.
Quite a lot of proposed micro-optimisations turn out to be pessimisations
except for the processor of the original proposer 8(
