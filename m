Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263686AbUEGQ5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUEGQ5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUEGQ5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:57:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28137 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263686AbUEGQ5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:57:02 -0400
Date: Fri, 7 May 2004 18:57:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040507165700.GE18175@atrey.karlin.mff.cuni.cz>
References: <20040506130846.GA241@elf.ucw.cz> <Pine.LNX.4.44.0405071652280.15067-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405071652280.15067-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Perhaps what we really want is "swap_back_in" script? That way you
> > could do "updatedb; swap_back_in" in cron and be happy.
> 
> swapoff -a; swapon -a

Good point... it will not bring back executable pages, through.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
