Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285499AbRLGUQi>; Fri, 7 Dec 2001 15:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285500AbRLGUQ3>; Fri, 7 Dec 2001 15:16:29 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:48133 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S285499AbRLGUQX>;
	Fri, 7 Dec 2001 15:16:23 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112072016.fB7KGIF402108@saturn.cs.uml.edu>
Subject: Re: vma->vm_end > 0x60000000
To: schwab@suse.de (Andreas Schwab)
Date: Fri, 7 Dec 2001 15:16:17 -0500 (EST)
Cc: wli@holomorphy.com (William Lee Irwin III),
        geert@linux-m68k.org (Geert Uytterhoeven),
        linux-kernel@vger.kernel.org (Linux Kernel Development),
        linux-m68k@lists.linux-m68k.org (Linux/m68k)
In-Reply-To: <jevgfj8m5z.fsf@sykes.suse.de> from "Andreas Schwab" at Dec 07, 2001 09:33:12 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, it is a leftover from the a.out times.  IMHO it should be removed
> completely.  "Library pages" has no meaning for ELF.

"Library pages" == unmodified execute-only pages mapped from a
file that is not the executable.
