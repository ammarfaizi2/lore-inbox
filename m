Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUJDRuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUJDRuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUJDRuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:50:14 -0400
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:36483 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S268365AbUJDRuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:50:09 -0400
Date: Mon, 4 Oct 2004 13:50:03 -0400
From: Jim Paris <jim@jtan.com>
To: William Knop <wknop@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
Message-ID: <20041004175003.GA10814@jim.sh>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu> <41617AA0.9020809@pobox.com> <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just got another oops while trying to cp from my md/raid5 array (2 of 3 
> sata drives) to another sata drive on the same controller. This time, 
> though, it said there's a bug in timer.c, line 405, and that the 
> stack's garbage. I'm thinking it has nothing to do with timer.c, and 
> something in md or libata is chomping all over the kernel.

Or else something else on your system is bad.  Like your CPU or RAM.
Run memtest for a while.

-jim
