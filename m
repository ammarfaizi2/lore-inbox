Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135617AbREFAiu>; Sat, 5 May 2001 20:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbREFAik>; Sat, 5 May 2001 20:38:40 -0400
Received: from www.inreko.ee ([195.222.18.2]:6844 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S135612AbREFAia>;
	Sat, 5 May 2001 20:38:30 -0400
Date: Sun, 6 May 2001 02:39:17 +0200
From: Marko Kreen <marko@l-t.ee>
To: "Magnus Naeslund(f)" <mag@fbab.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 fork() problems (maybe)
Message-ID: <20010506023917.A22722@l-t.ee>
In-Reply-To: <00fb01c0d596$afb30690$020a0a0a@totalmef> <20010505223034.C9629@l-t.ee> <018701c0d5c2$67a2ad20$020a0a0a@totalmef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018701c0d5c2$67a2ad20$020a0a0a@totalmef>; from mag@fbab.net on Sun, May 06, 2001 at 02:20:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 02:20:50AM +0200, Magnus Naeslund(f) wrote:
> From: "Marko Kreen" <marko@l-t.ee>
> > On Sat, May 05, 2001 at 09:07:53PM +0200, Magnus Naeslund(f) wrote:
> > > When i do a "su - <user>" it just hangs.
> > > When i run strace on it i see that it forks and wait()s on the child.

> No i use redhat 6.2 (on a alpha system).
> It works fine with 2.4.3, which i am running now ( i backed out 2.4.4 ).

Could you try 2.4.5-pre1?  If that too works then the problem
quite possibly was indeed fork() child-first change.  If not,
well, then it gets interesting...

-- 
marko

