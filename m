Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271515AbRHPHw5>; Thu, 16 Aug 2001 03:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271516AbRHPHwr>; Thu, 16 Aug 2001 03:52:47 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:40654 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S271515AbRHPHwh>;
	Thu, 16 Aug 2001 03:52:37 -0400
Message-ID: <20010816095249.20144@ally.lammerts.org>
Date: Thu, 16 Aug 2001 09:52:49 +0200
From: Eric Lammerts <eric@ally.lammerts.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer killing all threads
In-Reply-To: <Pine.LNX.4.33.0108132151110.31526-100000@ally.lammerts.org> <Pine.LNX.4.33.0108152114520.13614-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.79e
In-Reply-To: <Pine.LNX.4.33.0108152114520.13614-100000@twinlark.arctic.org>; from dean gaudet on Wed, Aug 15, 2001 at 09:20:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 15, 2001 at 09:20:36PM -0700, dean gaudet wrote:
> On Mon, 13 Aug 2001, Eric Lammerts wrote:
> > I recently had the following problem: Roxen (a webserver that uses
> > threads) was running out of control, eating up more and more memory.
> 
> this would be a bug in roxen.  for the corresponding code in apache, and

That wouldn't surprise me.

> roxen needs code to limit its own damage, i
> don't see why the kernel should do it...

Of course roxen needs to be fixed, but in the meantime I'd like to prevent
it from bringing the box down.

> hey -- is there a way to know when a task was OOM killed as opposed to
> other forms of death?

dmesg(8) ;-).

Eric
