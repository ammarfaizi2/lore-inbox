Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVLFWMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVLFWMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVLFWMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:12:31 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:22034 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932488AbVLFWMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:12:30 -0500
Date: Tue, 6 Dec 2005 23:12:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Patrick McLean <pmclean@cs.ubishops.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] clean-boot.pl version 0.1 - Simple utility to clean up /boot and /lib/modules
Message-ID: <20051206221222.GC7096@alpha.home.local>
References: <1133573415.32583.108.camel@localhost.localdomain> <20051203085734.GB22139@alpha.home.local> <4395C3E4.2070703@cs.ubishops.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395C3E4.2070703@cs.ubishops.ca>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 12:01:24PM -0500, Patrick McLean wrote:
> Willy Tarreau wrote:
> >One more reason to put kernels and modules into /boot. On my systems,
> >/lib/modules is a symlink to /boot
> 
> Not the best idea on distros that use a separate /boot partition that is 
> not mounted at boot by default (this is Gentoo's recommended setup).

It's not mounted just because usually there's nothing useful in it. If
you put useful things such as modules, then you'll mount it.

willy
