Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUHJM6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUHJM6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUHJM6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:58:00 -0400
Received: from jabberwock.ucw.cz ([81.31.5.130]:23262 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id S265098AbUHJM5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:57:15 -0400
Date: Tue, 10 Aug 2004 14:57:00 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       dwmw2@infradead.org, eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810125700.GA11596@kam.mff.cuni.cz>
References: <200408101245.i7ACj6EM014024@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101245.i7ACj6EM014024@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >BTW is it true that Burn-Proof reduces the quality exactly in the cases
> >where burning without Burn-Proof would ruin the disk?
> 
> This is why it is silly to tell people that they do not need locked memory and
> raised scheduling priority for CD/DVD writing.

Yes, but if it is true, you can safely turn on Burn-Proof by default,
since the only cases where it would hurt are the cases when it would
fail without Burn-Proof anyway.

Also, as many people regularly use non-suid-root cdrecord without
Burn-Proof being ever used (even though I don't assert that it is
always the case), I would very much appreciate if cdrecord could
be configured (in cdrecord.conf) that I really wish to run it
without mlocking and RT priority if I know what I'm doing.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
return(ENOTOBACCO); /* Read on an empty pipe */
