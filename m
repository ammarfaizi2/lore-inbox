Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUCANUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 08:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUCANUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 08:20:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53227 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261255AbUCANUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 08:20:02 -0500
Date: Mon, 1 Mar 2004 13:46:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Pavel Machek <pavel@ucw.cz>, M?ns Rullg?rd <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301124610.GA1744@openzaurus.ucw.cz>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <20040229181053.GD286@elf.ucw.cz> <yw1xznb120zn.fsf@kth.se> <20040301094023.GF352@elf.ucw.cz> <yw1xhdx8ani6.fsf@kth.se> <20040301103946.GA9171@atrey.karlin.mff.cuni.cz> <1078135138.3884.19.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078135138.3884.19.camel@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Can you provide specific examples? I can fix bugs if I'm given
> reproducible issues instead of hand waving :>
> 

Try compiling with regparm=3; you are likely to find some
missing asmlinkages.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

