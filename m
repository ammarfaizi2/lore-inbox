Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRKHR3q>; Thu, 8 Nov 2001 12:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276743AbRKHR3f>; Thu, 8 Nov 2001 12:29:35 -0500
Received: from [216.151.155.121] ([216.151.155.121]:22795 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S276751AbRKHR3Y>; Thu, 8 Nov 2001 12:29:24 -0500
To: "Drizzt Do'Urden" <drizzt.dourden@iname.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Module Licensing? (thinking a little more)
In-Reply-To: <NLEDJBJHJDOPHJOIBBAFOEIOCGAA.drizzt.dourden@iname.com>
From: Doug McNaught <doug@wireboard.com>
Date: 08 Nov 2001 12:29:11 -0500
In-Reply-To: "Drizzt Do'Urden"'s message of "Thu, 8 Nov 2001 18:00:45 +0100"
Message-ID: <m34ro5xjbs.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Drizzt Do'Urden" <drizzt.dourden@iname.com> writes:

> Yes, clause 3.a) "machine readable source code". A .s file is, "machine
> readable source code" by the assembler and by people that have enough time
> to lost.. It is like head.S, but using numeric labels and other stuff of
> that kind.
> 
> Btw I don't understand exactly the problem with the use of  asm code (in
> opcodes or in nemonics) and the GPL in this particular case . To me, it's
> "machine readable source code" by the assembler and if it's compilation
> produces exactly the same executable, and don't see the problem.

You need to read further down in section 3:

    The source code for a work means the preferred form of the work for
    making modifications to it.

If the code was originally written in assembler, than the assembler
source (with comments and meaningful variable names) is the "preferred 
form".  If written in C and compiled to assembler, it isn't.

IANAL, but the wording of the GPL is fairly clear.  Obfuscated and
semi-compiled source doesn't cut it.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
