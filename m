Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271097AbTGPTsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271098AbTGPTsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:48:42 -0400
Received: from node-d-d535.a2000.nl ([62.195.213.53]:37841 "EHLO bkor.dhs.org")
	by vger.kernel.org with ESMTP id S271097AbTGPTsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:48:41 -0400
Date: Wed, 16 Jul 2003 22:03:25 +0200
From: Olav Vitters <olav@bkor.dhs.org>
To: Magnus Solvang <magnus@solvang.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gnome-terminal hangs while running mutt (kernel 2.5.70)
Message-ID: <20030716200325.GA26150@bkor.dhs.org>
Mail-Followup-To: Magnus Solvang <magnus@solvang.net>,
	linux-kernel@vger.kernel.org
References: <20030606011104.GA4700@first.knowledge.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606011104.GA4700@first.knowledge.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 03:11:04AM +0200, Magnus Solvang wrote:
> Using gnome-terminal with an updated Red Hat Linux 9, and
> ssh'ing to my mailserver, my gnome-terminal hangs while
> mutt is sorting my mailbox. It always hangs on the same
> sort-count, displaying:
> 
>   Reading /var/spool/mail/magnus... 194 (38%)
> 
> on the bottom of the screen. This is not a problem with
> other kernels, or using xterm in 2.5.70, so I guess it's
> not a mutt-problem.
> 
> Starting a gnome-terminal from xterm, logging into my
> mailserver with ssh, and starting mutt, the following
> error message loops infinitly in xterm while gnome-terminal
> hangs:
> 
> ** (gnome-terminal:5486): WARNING **: Error reading from
>  child: Bad address.

This is actually a bug in vte and was fixed in version 0.10.26. Red Hat
9.0 seems to have vte 0.10.25. For more information please go to
http://bugzilla.gnome.org/show_bug.cgi?id=108066


-- 
Regards,
Olav
