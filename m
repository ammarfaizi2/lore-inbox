Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286667AbRL1Bmo>; Thu, 27 Dec 2001 20:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286653AbRL1BmX>; Thu, 27 Dec 2001 20:42:23 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:65030 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286649AbRL1BmA>;
	Thu, 27 Dec 2001 20:42:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Thu, 27 Dec 2001 17:37:39 -0800."
             <20011227173739.U25698@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 12:41:48 +1100
Message-ID: <18754.1009503708@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001 17:37:39 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>A couple of questions:
>
>a) will 2.5 be as fast as the current system?  Faster?

At the moment kbuild 2.5 ranges from 10% faster on small builds to 100%
slower on a full kernel build.  But that is using slow core code which
I know I can rewrite to make it significantly faster.

>b) what's the eta on 2.5?

kbuild 2.5 is ready now.  I am not even going to start on the core
rewrite until Linus takes the existing kbuild 2.5 code.  The existing
code works and is stable, doing a complete core rewrite just before
includeing in the kernel strikes me as stupid.

