Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUBWPGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUBWPGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:06:15 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:57622 "EHLO
	mwinf0901.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261919AbUBWPGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:06:13 -0500
Date: Mon, 23 Feb 2004 16:06:10 +0100
From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org, mathieu.castet@ensimag.imag.fr,
       tester@tester.ca, alban.crequy@apinc.org
Subject: Re: Linux 2.6.3 still doesn't boot on UltraSparc I
Message-ID: <20040223150610.GA24673@blop.info>
References: <20040210163232.GA2107@blop.info> <20040223133213.GA24179@blop.info> <20040223132502.GB4407@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223132502.GB4407@phunnypharm.org>
Organisation: Lacking
X-PGP: http://www.lucas-nussbaum.net/pubkey.txt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 08:25:02AM -0500, Ben Collins <bcollins@debian.org> wrote:
> So backing down to silo < 1.4.0 works with the new head.S on UltraSPARC
> I? I don't think the problem itself is in head.S. Changing that would
> force silo 1.4.x to not keep the kernel in high memory (would copy it
> back down to 0x4000 where the old silo would have put it). I am guessing
> the problem is elsewhere.
> 
> Try this, keep the new head.S and newer SILO, and edit head.S so that
> "HdrS version" is 0x202 instead of 0x300. See if that boots for you
> (would confirm my suspicion).

It boots correctly this way. What can we do to help now ?

Lucas
