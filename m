Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUG0UK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUG0UK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUG0UK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:10:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24529 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266566AbUG0UKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:10:24 -0400
Date: Mon, 26 Jul 2004 22:54:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nuno Tavares <nunotavares@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JPEG/JFIF that will cause mozilla hang,	kernel lock and sometimes reboot (FC2)
Message-ID: <20040726205431.GA21889@openzaurus.ucw.cz>
References: <pan.2004.07.24.15.05.44.724512@hotmail.com> <pan.2004.07.25.00.23.23.419467@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.07.25.00.23.23.419467@hotmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This i very odd, I haven't seen this for years. I have a JPEG/JFIF that
> when opened with Mozilla will lock the whole system, and sometimes will
> reboot the system after a little while.
> 
> My short investigation led me to conclude that this is a bug both in
> kernel (as it reboots) and in Gecko-based browsers - gecko is the
> HTML rendering engine used in Mozilla, Firefox, Epiphany and probably
> others. This last assumption is due that Konqueror will not crash.
> 
> Unfortunely, the JPEG file has some sensitive information, and this hasn't
> happened with anyother. No error messages, nothing. I'm looking for ways
> to debug this, both firefox and the kernel. How do I do that?

Switch to text console, killall klogd, DISPLAY=:0.0 mozilla <url>,
look for messages.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

