Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbSJFUUr>; Sun, 6 Oct 2002 16:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262172AbSJFUUr>; Sun, 6 Oct 2002 16:20:47 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:57067 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262168AbSJFUUo>; Sun, 6 Oct 2002 16:20:44 -0400
Date: Sun, 6 Oct 2002 17:26:02 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
In-Reply-To: <20021006024902.GB31878@pegasys.ws>
Message-ID: <Pine.LNX.4.44L.0210061724530.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, jw schultz wrote:

> > TASK_UNINTERRUPTIBLE processes are counted in count_active_tasks() -
> > because it is assumed they will only sleep a very short while - which is
> > what is used in the load balance.
>
> I stand corrected.  The load average reported will reflect
> them.  The D-state processes, however, will have nearly zero
> effect on the system performance, yes?

Ummm, if your X server and window manager are in D state,
that has as big an effect on system performance as you can
imagine...

> So in this case the load average reported is simply an infated number.

Not really, IO wait is often a much larger slowdown factor
than CPU occupancy.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

