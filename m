Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269333AbRHCHKR>; Fri, 3 Aug 2001 03:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269335AbRHCHJ6>; Fri, 3 Aug 2001 03:09:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45122 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269333AbRHCHJu>; Fri, 3 Aug 2001 03:09:50 -0400
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
In-Reply-To: <20010802193750.B12425@emma1.emma.line.org>
	<Pine.LNX.4.33.0108030051070.1703-100000@fogarty.jakma.org>
	<20010803021642.B9845@emma1.emma.line.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Aug 2001 01:03:26 -0600
In-Reply-To: <20010803021642.B9845@emma1.emma.line.org>
Message-ID: <m1puady69t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> On Fri, 03 Aug 2001, Paul Jakma wrote:
> 
> > if the prime directive of MTAs is data integrity paranoia, then
> > surely the best assumption for an MTA to make is that
> > rename/link/unlink/symlink /are/ asynchronous in the general case?
> 
> They do on Linux, use chattr +S, and are much slower than e. g. on
> FreeBSD. Well. Not that I'd written THAT for the first time...

Actually given that this thread keeps coming up, but no one does anything
about it.  I'm tempted to suggest we remove chatrr +S support from ext2.
Then there will be enough pain that someone will fix the MTA instead of
moaning that kernel is slow...

That should be an easy patch to make...

Eric
