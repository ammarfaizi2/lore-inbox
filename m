Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135328AbREEUaQ>; Sat, 5 May 2001 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135318AbREEUaH>; Sat, 5 May 2001 16:30:07 -0400
Received: from www.inreko.ee ([195.222.18.2]:50617 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S135339AbREEU34>;
	Sat, 5 May 2001 16:29:56 -0400
Date: Sat, 5 May 2001 22:30:34 +0200
From: Marko Kreen <marko@l-t.ee>
To: "Magnus Naeslund(f)" <mag@fbab.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 fork() problems (maybe)
Message-ID: <20010505223034.C9629@l-t.ee>
In-Reply-To: <00fb01c0d596$afb30690$020a0a0a@totalmef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00fb01c0d596$afb30690$020a0a0a@totalmef>; from mag@fbab.net on Sat, May 05, 2001 at 09:07:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 09:07:53PM +0200, Magnus Naeslund(f) wrote:
> Hello, I saw that there was something changed on how fork() works, and
> wonder if this could be the cause my problem.
> When i do a "su - <user>" it just hangs.
> When i run strace on it i see that it forks and wait()s on the child.
> 
> Sometimes when i strace the su command it succeeds to give me a shell,
> sometimes not.
> But it allways fails when i don't strace it.

2.4.4 has some problems with fork() but your problem seems to be
something else.  Are you using RedHat 7.1?  (Or whatever it was
the latest...)  The su-acting-weird problem has been reported 
before and was traced to some PAM problems.  Try to download
some upgrades from RedHat, maybe it will help.

-- 
marko

