Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbTE0VLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTE0VLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:11:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51867
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264184AbTE0VLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:11:24 -0400
Date: Tue, 27 May 2003 23:24:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 00_drop-broken-flock-account-1
Message-ID: <20030527212436.GU3767@dualathlon.random>
References: <Pine.LNX.4.55L.0305270313550.813@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305270313550.813@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 03:16:18AM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Is this patch suitable for mainline inclusion?
> 
>         per-task flock accounting was broken across tasks sharing the same
>         files. Removed temporarly. This should fix sendmail. If somebody
>         wanted to bypass the rlimit he needed simply to use fcntl instead
>         so it's not going to make much difference for 2.4. Fix from
>         Matthew Wilcox.

yes, and as I wrote above the rlimit was trivial anyways to bypass with fcntl.

Andrea
