Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269038AbUJEOki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269038AbUJEOki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUJEOki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:40:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51329 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269059AbUJEOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:40:36 -0400
Date: Tue, 5 Oct 2004 00:26:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix suspending with mysqld
Message-ID: <20041004222647.GA4723@openzaurus.ucw.cz>
References: <20041004122422.GA2601@elf.ucw.cz> <200410042109.58519.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410042109.58519.lkml@kcore.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > mysqld does signal calls in pretty tight loop, and swsusp is not able
> > to stop processes in such case. This should fix it. Please apply,
> 
> I applied your patch to 2.6.9-rc3. Unfortunately, now the system doesn't suspend anymore, it comes back almost immediately:
> 

And it did work before that patch? I fail to see how this patch could have
broken anything.
				Pavel


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

