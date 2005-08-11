Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVHKSlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVHKSlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVHKSlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:41:47 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:60842 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S932356AbVHKSlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:41:47 -0400
Date: Thu, 11 Aug 2005 21:41:44 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: fcntl(F_GETLEASE) semantics??
Message-ID: <20050811184144.GE31158@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <17146.37443.505736.147373@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
> if (fcntl(fd, F_SETLEASE, F_RDLCK) == -1)
>     fail;

Is that something inotify can do? If so, then should F_SETLEASE/GETLEASE
be deprecated for future? F_SETLEASE is Linux specific, and inotify is
generally more useful. It looks like inotify could be used to detected 
changes in any file.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
