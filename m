Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268545AbTBWUoN>; Sun, 23 Feb 2003 15:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268547AbTBWUoN>; Sun, 23 Feb 2003 15:44:13 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:39646 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S268545AbTBWUoM>; Sun, 23 Feb 2003 15:44:12 -0500
Date: Sun, 23 Feb 2003 17:53:58 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: David Mansfield <david@cobite.com>
cc: David Mansfield <lkml@dm.cobite.com>, "" <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: oom killer and its superior braindamage in 2.4
In-Reply-To: <Pine.LNX.4.44.0302231519520.23778-100000@admin>
Message-ID: <Pine.LNX.4.50L.0302231753090.2206-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0302231519520.23778-100000@admin>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, David Mansfield wrote:

> So you're saying that a process can stay in the D state, without ever
> getting enough resources to complete a single Uninteruptible wait, for
> hours at a time?

Or even in the R state, but that would only happen when there
is a kernel bug.  The OOM killer can do nothing but hope for
the best and try another process if the first one doesn't want
to exit.

> Ok.  Now I understand your patch.  Thanks for the info.
>
> You should push your patch to Marcelo.

Will do.

cheers,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
